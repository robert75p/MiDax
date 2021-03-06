﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using MidaxLib;

namespace MidaxTester
{
    public class ANN
    {
        static Trader _trader;
        static AutoResetEvent _stopEvent;
        static bool _generate;

        public static void Run(List<DateTime> dates, bool generate = false, bool generate_from_db = false, bool publish_to_db = false, bool use_uat_db = false)
        {
            Config.Settings = new Dictionary<string, string>();
            if (use_uat_db)
                Config.Settings["TRADING_MODE"] = "REPLAY_UAT";
            else
                Config.Settings["TRADING_MODE"] = "REPLAY";
            Config.Settings["REPLAY_MODE"] = generate_from_db ? "DB" : "CSV";
            if (generate_from_db)
                Config.Settings["DB_CONTACTPOINT"] = "192.168.1.26";
            Config.Settings["TRADING_LIMIT_PER_BP"] = "10";
            Config.Settings["TIMESERIES_MAX_RECORD_TIME_HOURS"] = "12";
            Config.Settings["VOLATILITY"] = "VIX2:IN.D.VIX.MONTH2.IP";
            //Config.Settings["TRADING_SIGNAL"] = "";

            _generate = generate;
            string action = generate ? "Generating" : "Testing";

            List<MarketData> stocks = new List<MarketData>();
            foreach (var test in dates)
            {
                List<string> mktdataFiles = new List<string>();
                mktdataFiles.Add(string.Format("..\\..\\expected_results\\ann_{0}_{1}_{2}.csv", test.Day, test.Month, test.Year));
                Config.Settings["REPLAY_CSV"] = Config.TestList(mktdataFiles);
                if (publish_to_db)
                {
                    Config.Settings["PUBLISHING_START_TIME"] = string.Format("{0}-{1}-{2} {3}:{4}:{5}", test.Year, test.Month, test.Day, 6, 30, 0);
                    Config.Settings["PUBLISHING_STOP_TIME"] = string.Format("{0}-{1}-{2} {3}:{4}:{5}", test.Year, test.Month, test.Day, 22, 45, 0);
                    Config.Settings["TRADING_START_TIME"] = string.Format("{0}-{1}-{2} {3}:{4}:{5}", test.Year, test.Month, test.Day, 8, 0, 0);
                    Config.Settings["TRADING_STOP_TIME"] = string.Format("{0}-{1}-{2} {3}:{4}:{5}", test.Year, test.Month, test.Day, 21, 30, 0);
                    Config.Settings["TRADING_CLOSING_TIME"] = string.Format("{0}-{1}-{2} {3}:{4}:{5}", test.Year, test.Month, test.Day, 16, 30, 0);
                }
                else
                {
                    Config.Settings["PUBLISHING_START_TIME"] = string.Format("{0}-{1}-{2} {3}:{4}:{5}", test.Year, test.Month, test.Day, 6, 45, 0);
                    Config.Settings["PUBLISHING_STOP_TIME"] = string.Format("{0}-{1}-{2} {3}:{4}:{5}", test.Year, test.Month, test.Day, 9, 30, 0);
                    Config.Settings["TRADING_START_TIME"] = string.Format("{0}-{1}-{2} {3}:{4}:{5}", test.Year, test.Month, test.Day, 8, 0, 0);
                    Config.Settings["TRADING_STOP_TIME"] = string.Format("{0}-{1}-{2} {3}:{4}:{5}", test.Year, test.Month, test.Day, 9, 25, 0);
                    Config.Settings["TRADING_CLOSING_TIME"] = string.Format("{0}-{1}-{2} {3}:{4}:{5}", test.Year, test.Month, test.Day, 9, 15, 0);
                }
                if (generate)
                {
                    if (!publish_to_db)
                        Config.Settings["PUBLISHING_CSV"] = string.Format("..\\..\\expected_results\\anngen_{0}_{1}_{2}.csv", test.Day, test.Month, test.Year);
                }

                MarketDataConnection.Instance.Connect(null);
                var models = new List<Model>();
                models.Add(new ModelMacDTest(new MarketData("DAX:IX.D.DAX.DAILY.IP"), 2, 10, 60));
                List<MarketData> otherIndices = new List<MarketData>();
                otherIndices.Add(new MarketData("DOW:IX.D.DOW.DAILY.IP"));
                otherIndices.Add(new MarketData("CAC:IX.D.CAC.DAILY.IP"));
                models.Add(new ModelANN((ModelMacD)models[0], new List<MarketData>(), new MarketData(Config.Settings["VOLATILITY"]), otherIndices));
                Console.WriteLine(action + string.Format(" the ANN daily record {0}-{1}-{2}...", test.Year, test.Month, test.Day));
                _trader = new Trader(models, onShutdown);
                if (generate)
                {
                    _trader.Start();
                    _trader.Stop();
                }
                else
                {
                    _trader.Init(GetNow);
                    _stopEvent = new AutoResetEvent(false);
                    _stopEvent.WaitOne();
                }
            }
        }

        static DateTime GetNow()
        {
            return Config.ParseDateTimeLocal(Config.Settings["PUBLISHING_STOP_TIME"]).AddMinutes(-5);
        }

        static void onShutdown()
        {
            if (!_generate)
            {
                if (ReplayTester.Instance.NbProducedTrades != ReplayTester.Instance.NbExpectedTrades)
                    _trader.ProcessError(string.Format("the model did not produced the expected number of trades. It produced {0} trades instead of {1} expected",
                                                    ReplayTester.Instance.NbProducedTrades, ReplayTester.Instance.NbExpectedTrades));
            }
            _stopEvent.Set();
        }
    }
}
