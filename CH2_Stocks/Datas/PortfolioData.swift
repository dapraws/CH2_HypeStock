//
//  PortfolioData.swift
//  CH2_Stocks
//
//  Created by Amadeus on 23/04/26.
//

import Foundation
internal import Combine


class PortfolioData: ObservableObject {
    @Published var portfolios: [Portfolio] = []
    func buy(stock: Stock, quantity: Int, date: Date = Date()) {
        self.portfolios.append(Portfolio(stock: stock, quantity: quantity, date: date))
    }
    func sell(stock: Stock, quantity: Int, date: Date = Date()) {
        self.portfolios.append(Portfolio(stock: stock, quantity: quantity * -1, date: date))
    }
    
    
    func getExistingProfit() -> Double{
        var res: Double = 0.0
        var existingStock: [Portfolio] = []
        for item in portfolios {
            if item.quantity >= 0 {
                existingStock.append(item)
            } else {
                var remaining = -item.quantity
                var index = 0
                
                while remaining > 0 && index < existingStock.count {
                    if existingStock[index].quantity > remaining {
                        
                        let newStock = Portfolio(stock: existingStock[index].stock, quantity: existingStock[index].quantity - remaining, date: existingStock[index].date)
                        existingStock[index] = newStock
                        remaining = 0
                        index += 1
                    } else {
                        remaining -= existingStock[index].quantity
                        existingStock.remove(at: index)
                    }
                }
            }
        }
        
        for item in existingStock {
            res += (item.stock.getLastPrice() - item.price) * Double(item.quantity)
        }
        
        return res
        
    }
    
    
}
