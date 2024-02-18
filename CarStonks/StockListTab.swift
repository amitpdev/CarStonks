//
//  StonksList.swift
//  CarStonks
//
//  Created by Amit on 05/03/2021.
//

import Foundation
import CarPlay

class StockListTab {

    private(set) var listTemplate: CPListTemplate
    
    init(list: StockList) {
        listTemplate = CPListTemplate(title: list.tabTitle, sections: [])
        listTemplate.tabImage = UIImage(named: list.tabImage)
    }
}


extension StockListTab: StockDataObserver {
    
    func didFetchStocks(stocks: [Stock]) {
        debugPrint("Fetched \(stocks.count) Stocks")
        let cpItems = StockListTab.cpItems(from: stocks)
        listTemplate.updateSections([CPListSection(items: cpItems)])
    }
}


extension StockListTab {
    class func cpItems(from stocks: [Stock]) -> [CPListItem] {
        var items = [CPListItem]()
        for stock in stocks {
            var text = stock.symbol
                .padding(toLength: 15, withPad: " ", startingAt: 0)
            
            text += (String(format: "$%.2f", stock.regularMarketPrice))
                .padding(toLength: 15, withPad: " ", startingAt: 0)
            
            text += (String(format: "%.2f", stock.regularMarketChangePercent) + "%")
                .padding(toLength: 15, withPad: " ", startingAt: 0)
            
            var item: CPListItem? = nil
            
            if let url = stock.coinImageUrl {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    let resizedImage = image.resized(to: CGSize(width: 20, height: 20))
                        item = CPListItem(text: text, detailText: stock.shortName, image: resizedImage)
                }
            } else {
                item = CPListItem(text: text, detailText: stock.shortName)
            }
            
            // stop spinner on item tap
            item?.handler = {item, completion in
                completion()
            }
            
            if let item = item {
                items.append(item)
            }
        }
        
        return items
        
    }
}


extension UIImage {
    func resized(to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}
