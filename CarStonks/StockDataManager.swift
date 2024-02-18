//
//  StockDataManager.swift
//  CarStonks
//
//  Created by Amit Palomo on 05/03/2021.
//

import Foundation
import SwiftYFinance


protocol StockDataObserver: AnyObject {
    func didFetchStocks(stocks: [Stock])
}

class StockDataManager {
    
    private var observers: [String: StockDataObserver] = [:]
    private var timer: Timer? = nil
    
    func addObserver(_ observer: StockDataObserver, forStockList listName: String) {
        observers[listName] = observer
    }
    
    func fetchDataNow(_ lists: [StockList]) {
        for list in lists {
            StockDataManager.fetchStockQuotes(symbols: list.symbols) { stocks in
                self.observers[list.tabTitle]?.didFetchStocks(stocks: stocks)
            }
        }
    }
    
    func registerTimer(for lists: [StockList]) {
        timer = Timer.scheduledTimer(
            withTimeInterval: Config.refreshInterval,
            repeats: true,
            block: { (timer) in
                self.fetchDataNow(lists)
        })
    }
}

extension StockDataManager {
    
    static func fetchStockQuotes(symbols: [String], completion: @escaping ([Stock]) -> ()) {
        SwiftYFinance.quote(identifiers: symbols) { data, error in
            guard let data = data, error == nil else {
                debugPrint("Error during fetchStockQuotes")
                return
            }
            
            let stocks = data.compactMap {
                return Stock(shortName: $0.shortName,
                              symbol: $0.symbol,
                              regularMarketPrice: $0.regularMarketPrice,
                              regularMarketChangePercent: $0.regularMarketChangePercent,
                              coinImageURLString: $0.coinImageUrl)
            }
            
            completion(stocks)
        }
    }
}
