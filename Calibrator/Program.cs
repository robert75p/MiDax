﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MidaxLib;

namespace Calibrator
{
    class Program
    {
        static void Main(string[] args)
        {
            DateTime start = Config.ParseDateTimeLocal(args[0]);
            DateTime end = Config.ParseDateTimeLocal(args[1]);

            Dictionary<string, string> dicSettings = new Dictionary<string, string>();
            dicSettings["APP_NAME"] = "Midax";
            dicSettings["LIMIT"] = "10";
            dicSettings["DB_CONTACTPOINT"] = "192.168.1.26";
            dicSettings["REPLAY_MODE"] = "CSV";
            dicSettings["TRADING_MODE"] = "CALIBRATION";
            Config.Settings = dicSettings;

            // read market data and indicator values
            var marketData = new Dictionary<string, List<CqlQuote>>();
            var indicatorData = new Dictionary<string, List<CqlQuote>>();
            var profitData = new Dictionary<string, List<double>>();
            string[] ids = new string[1];
            ids[0] = "IX.D.DAX.DAILY.IP";
            while (start <= end)
            {
                List<string> mktdataFiles = new List<string>();
                mktdataFiles.Add(string.Format("..\\..\\..\\MarketSelector\\MktSelectorData\\mktselectdata_{0}_{1}_{2}.csv", start.Day, start.Month, start.Year));
                Config.Settings["REPLAY_CSV"] = Config.TestList(mktdataFiles);
                Config.Settings["PUBLISHING_START_TIME"] = string.Format("{0}-{1}-{2} {3}:{4}:{5}", start.Year, start.Month, start.Day, 6, 45, 0);
                Config.Settings["PUBLISHING_STOP_TIME"] = string.Format("{0}-{1}-{2} {3}:{4}:{5}", start.Year, start.Month, start.Day, 18, 0, 0);
                Config.Settings["TRADING_START_TIME"] = string.Format("{0}-{1}-{2} {3}:{4}:{5}", start.Year, start.Month, start.Day, 8, 0, 0);
                Config.Settings["TRADING_STOP_TIME"] = string.Format("{0}-{1}-{2} {3}:{4}:{5}", start.Year, start.Month, start.Day, 17, 0, 0);
                Config.Settings["TRADING_CLOSING_TIME"] = string.Format("{0}-{1}-{2} {3}:{4}:{5}", start.Year, start.Month, start.Day, 16, 55, 0);
                //Config.Settings["PUBLISHING_CSV"] = string.Format("..\\..\\CalibrationData\\calibdata_{0}_{1}_{2}.csv", start.Day, start.Month, start.Year);

                var client = new ReplayStreamingClient();
                client.Connect();
                Dictionary<string, List<CqlQuote>> curDayMktData = client.GetReplayData(ids);
                foreach (var keyVal in curDayMktData)
                {
                    var processableMktData = new List<CqlQuote>();
                    foreach (var quote in keyVal.Value)
                    {
                        if (client.ExpectedIndicatorData["WMA_90_" + ids[0]].Select(cqlq => cqlq.t).Contains(quote.t))
                            processableMktData.Add(quote);
                    }
                    if (marketData.ContainsKey(keyVal.Key))
                        marketData[keyVal.Key].AddRange(processableMktData);
                    else
                        marketData[keyVal.Key] = processableMktData;
                }
                foreach (var keyVal in client.ExpectedIndicatorData)
                {
                    if (indicatorData.ContainsKey(keyVal.Key))
                        indicatorData[keyVal.Key].AddRange(keyVal.Value);
                    else
                        indicatorData[keyVal.Key] = keyVal.Value;
                }
                foreach (var keyVal in client.ExpectedProfitData)
                {
                    if (!profitData.ContainsKey(keyVal.Key.Key))
                        profitData[keyVal.Key.Key] = new List<double>();
                    profitData[keyVal.Key.Key].Add(keyVal.Value);                        
                }

                // process next day
                do
                {
                    start = start.AddDays(1);
                }
                while (start.DayOfWeek == DayOfWeek.Saturday || start.DayOfWeek == DayOfWeek.Sunday);
            }

            var error = 100.0;
            int trials = 10;
            NeuralNetworkWMA_5_2 ann = null;
            var rndSeed = new Random();
            while (trials-- > 0)
            {
                var annTest = new NeuralNetworkWMA_5_2(ids[0], marketData, indicatorData, profitData);
                annTest.Train(5.0, rndSeed.Next(1000));
                if (annTest.Error < error)
                {
                    error = annTest.Error;
                    ann = annTest;
                }
            }

            DialogResult dialogResult = MessageBox.Show(string.Format("The calibration error is {0}.\n The learning rate is {1}%.\n Would you like to publish the weights to production DB?",
                ann.Error, ann.LearningRatePct), ann.GetType().ToString(), MessageBoxButtons.YesNo);
            if (dialogResult == DialogResult.Yes)
                PublisherConnection.Instance.Insert(DateTime.Now, ann);
        }

        static void OnUpdateMktData(MarketData mktData, DateTime updateTime, Price value)
        {
        }
    }
}
