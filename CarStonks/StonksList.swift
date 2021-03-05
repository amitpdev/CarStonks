//
//  StonksList.swift
//  CarStonks
//
//  Created by Amit on 05/03/2021.
//

import Foundation
import CarPlay

class StonksList {
    
    var symbols: [String]
    var stonks = [Stonk]()
    
    var timer: Timer? = nil
    
    var cpItems: [CPListItem] {
        stonks.map {
            
            var text = $0.symbol
                .padding(toLength: 15, withPad: " ", startingAt: 0)
            
            text += (String(format: "$%.2f", $0.regularMarketPrice))
                
                .padding(toLength: 15, withPad: " ", startingAt: 0)
            
            text += (String(format: "%.2f", $0.regularMarketChangePercent) + "%")
                .padding(toLength: 15, withPad: " ", startingAt: 0)
            
            
            var item: CPListItem
            
            if let url = $0.coinImageUrl {
                let data = try? Data(contentsOf: url)
                item = CPListItem(text: text, detailText: $0.shortName , image: UIImage(data: data!))
            }
            else {
                item = CPListItem(text: text, detailText: $0.shortName)
            }
            
            // stop spinner on item tap
            item.handler = {item, completion in
                completion()
            }
            
            return item

        }
    }
    
    
    lazy var listTemplate = CPListTemplate(
        title: "",
        sections: [CPListSection(items: cpItems)]
    )
    
    func fetchDataAndRefresh() {
        StonkData.fetchStonkQuotes(symbols: self.symbols) { stonks in
            self.stonks = stonks
            self.listTemplate.updateSections([CPListSection(items: self.cpItems)])
        }
    }
    
    init(symbols: [String], tabTitle: String, tabImage: String) {
        
        self.symbols = symbols
        self.listTemplate.tabTitle = tabTitle
        self.listTemplate.tabImage = UIImage(named: tabImage)

        self.fetchDataAndRefresh()
        
        timer = Timer.scheduledTimer(withTimeInterval: Config.refreshInterval, repeats: true, block: { (timer) in
            self.fetchDataAndRefresh()
        })
    }
        
}
