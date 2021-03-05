//
//  Stonk.swift
//  CarStonks
//
//  Created by Amit on 05/03/2021.
//

import Foundation

typealias JSONObject = [String: Any]

struct Stonk {
    var shortName: String
    var symbol: String
    var regularMarketPrice: Double
    var regularMarketChangePercent: Double
    var coinImageUrl: URL?
    
    init?(json: JSONObject) {
        guard let shortName = json["shortName"] as? String,
            let symbol = json["symbol"] as? String,
            let regularMarketPrice = json["regularMarketPrice"] as? Double,
            let regularMarketChangePercent = json["regularMarketChangePercent"] as? Double
            else {
                debugPrint("\(#function) could not initialize Stonk \(json)")
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
}

