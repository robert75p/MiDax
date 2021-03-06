﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using Lightstreamer.DotNet.Client;

namespace MidaxLib
{
    public class Position
    {
        string _name;
        int _quantity = 0;
        decimal _assetValue = 0.0m;
        Trade _lastTrade = null;
        Trade _incomingTrade = null;
        Dictionary<string, int> _tradePositions = new Dictionary<string, int>();
        public int Quantity
        {
            get { return _quantity; }
            set { _quantity = value; }
        }
        public decimal AssetValue
        {
            get { return _assetValue; }
        }
        public string Epic { get { return _name; } }
        public Trade Trade { get { return _lastTrade; } }
        public Trade IncomingTrade { set { _incomingTrade = value; } }

        public bool Closed
        {
            get
            {
                return _tradePositions.Count == 0;
            }
        }

        public bool AwaitingTrade
        {
            get
            {
                return _incomingTrade != null;
            }
        }

        public Position(string name)
        {
            _name = name;
        }

        public void OnRawUpdatesLost(int lostUpdates)
        {
            Log.Instance.WriteEntry(string.Format("Position {0}: {1} Raw Updates Lost", _name, lostUpdates), System.Diagnostics.EventLogEntryType.Warning);
        }

        public void OnSnapshotEnd()
        {
        }

        public void OnUnsubscr()
        {
            Log.Instance.WriteEntry(string.Format("Unsubscribed {0}, last position was: {1}", _name, _quantity), System.Diagnostics.EventLogEntryType.Warning);
        }

        public void OnUnsubscrAll()
        {
            Log.Instance.WriteEntry(string.Format("Unsubscribed {0}, last position was: {1}", _name, _quantity), System.Diagnostics.EventLogEntryType.Warning);
        }

        public bool OnUpdate(IUpdateInfo update)
        {
            if (_incomingTrade == null)
                return false;
            if (update == null)
                return false;
            if (update.NumFields == 0)
                return false;
            JavaScriptSerializer json_serializer = new JavaScriptSerializer();
            if ((update.ToString().Replace(" ", "") == "[(null)]") || (update.ToString().Replace(" ", "") == "[null]"))
                return false;
            Log.Instance.WriteEntry("Incoming position update: " + update.ToString());
            var json = json_serializer.DeserializeObject(update.ToString());
            if (json.GetType().ToString() == "System.Object[]")
            {
                object[] objs = (object[])json;
                if (objs != null)
                {
                    foreach (var obj in objs)
                    {
                        var trade_notification = (Dictionary<string, object>)obj;
                        if (trade_notification != null)
                        {
                            if (trade_notification["dealStatus"].ToString() == "ACCEPTED")
                            {
                                if (trade_notification["epic"].ToString() == _name)
                                {
                                    if (trade_notification["status"].ToString() == "OPEN")
                                    {
                                        if (!AwaitingTrade || !Closed)
                                            return false;
                                        _lastTrade = _incomingTrade;
                                        _incomingTrade = null;
                                        var tradeSize = int.Parse(trade_notification["size"].ToString());
                                        _lastTrade.Id = trade_notification["dealId"].ToString();
                                        _lastTrade.Price = decimal.Parse(trade_notification["level"].ToString());
                                        _assetValue = _lastTrade.Price;
                                        if (trade_notification["direction"].ToString() == "SELL")
                                            tradeSize *= -1;
                                        else if (trade_notification["direction"].ToString() != "BUY")
                                            tradeSize = 0;
                                        _tradePositions[_lastTrade.Id] = tradeSize;
                                        _quantity += tradeSize;
                                        Log.Instance.WriteEntry("Created a new trade: " + _lastTrade.Id);
                                        _lastTrade.Publish();
                                        return true;
                                    }
                                    else if (trade_notification["status"].ToString() == "DELETED")
                                    {
                                        if (!AwaitingTrade || Closed)
                                            return false;
                                        string dealId = trade_notification["dealId"].ToString();
                                        if (!_tradePositions.ContainsKey(dealId))
                                            return false;                                        
                                        _quantity -= _tradePositions[dealId];
                                        _tradePositions.Remove(trade_notification["dealId"].ToString());
                                        Log.Instance.WriteEntry("Closed a trade: " + trade_notification["dealId"].ToString());
                                        _incomingTrade.Publish();
                                        _lastTrade = null;
                                        _incomingTrade = null;
                                        return true;
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Log.Instance.WriteEntry("Could not process an update: " + update.ToString(), System.Diagnostics.EventLogEntryType.Error);
            return false;
        }
    }
}
