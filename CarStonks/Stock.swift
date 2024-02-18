//
//  Stock.swift
//  CarStonks
//
//  Created by Amit on 05/03/2021.
//

import Foundation

typealias JSONObject = [String: Any]

struct Stock {
    let shortName: String
    let symbol: String
    let regularMarketPrice: Double
    let regularMarketChangePercent: Double
    var coinImageUrl: URL?
    
    init?(json: JSONObject) {
        guard let shortName = json["shortName"] as? String,
            let symbol = json["symbol"] as? String,
            let regularMarketPrice = json["regularMarketPrice"] as? Double,
            let regularMarketChangePercent = json["regularMarketChangePercent"] as? Double
            else {
                debugPrint("\(#function) could not initialize Stock \(json)")
                return nil
        }

        if let coinImageUrlString = json["coinImageUrl"] as? String,
           let coinImageUrl = URL(string: coinImageUrlString) {
            self.coinImageUrl = coinImageUrl
        }

        self.shortName = shortName
        self.symbol = symbol
        self.regularMarketPrice = regularMarketPrice
        self.regularMarketChangePercent = regularMarketChangePercent
    }
    
    
    init?(shortName: String?,
          symbol: String?,
          regularMarketPrice: Double?,
          regularMarketChangePercent: Double?,
          coinImageURLString: String?) {
        
        guard let shortName = shortName,
              let symbol = symbol,
              let regularMarketPrice = regularMarketPrice,
              let regularMarketChangePercent = regularMarketChangePercent
        else {
            return nil
        }
        self.shortName = shortName
        self.symbol = symbol
        self.regularMarketPrice = regularMarketPrice
        self.regularMarketChangePercent = regularMarketChangePercent
        
        if let coinImageURLString = coinImageURLString,
           let coinImageUrl = URL(string: coinImageURLString) {
            self.coinImageUrl = coinImageUrl
        }
    }
}

struct StockList: Hashable {
    let symbols: [String]
    let tabTitle: String
    let tabImage: String
}
