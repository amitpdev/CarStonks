//
//  StonkData.swift
//  CarStonks
//
//  Created by Amit on 05/03/2021.
//

import Foundation
import Forest

class StonkData {
    
    static func fetchStonkQuotes(symbols: [String], completion: @escaping ([Stonk]) -> ()) {
        ServiceTask()
            .url("https://query1.finance.yahoo.com/v7/finance/quote?lang=en-US&region=US&corsDomain=finance.yahoo.com")
            .method(.GET)
            .query(["symbols": symbols.joined(separator:",")])
            // Expecting valid JSON response
            .json { (object, response) in
                
                print("JSON response received: \(object)")
                
                guard let json = object as? JSONObject,
                let quoteResponse = json["quoteResponse"] as? JSONObject,
                let result = quoteResponse["result"] as? [JSONObject]
                else {
                    completion([])
                    return
                }
                
                let stonks = result.compactMap({Stonk(json: $0)})
                completion(stonks)
                
            }
            .error { (error, response) in
                print("Error occurred: \(error)")
                completion([])
            }
            .perform()
    }
}
