//
//  Config.swift
//  CarStonks
//
//  Created by Amit on 05/03/2021.
//

import Foundation

struct Config {
    
    static let refreshInterval = 40.0
    
    static let stonkList = StockList(
        symbols: [
            //"^SPX",
            "FVRR",
            "UPWK",
            "LMND",
            "GOOG",
            "AAPL",
            "MSFT",
            "META",
            "NVDA",
            "TSLA",
            "ZM",
            "GME",
            "AMC"
        ],
        tabTitle: "Stonks",
        tabImage: "stonksBarIcon")
    
    static let cryptoList = StockList(
        symbols: [
            "BTC-USD",
            "ETH-USD",
            "MATIC-USD",
            "AVAX-USD",
            "SOL-USD",
            "ZIL-USD",
            "JST-USD",
            "BNB-USD",
            "ADA-USD",
            "BTT-USD",
            "DOGE-USD",
            "LINK-USD",
            "DOT1-USD",
            "XMR-USD",
            "LUNA1-USD",
            "MANA-USD",
            "RNDR-USD"
            ],
        tabTitle: "Crypto",
        tabImage: "cryptoBarIcon")
}
