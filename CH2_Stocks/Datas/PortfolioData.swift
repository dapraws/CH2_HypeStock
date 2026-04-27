//
//  PortfolioData.swift
//  CH2_Stocks
//
//  Created by Amadeus on 23/04/26.
//

import Foundation
internal import Combine


class PortfolioData: ObservableObject {
    @Published var portfolios: [Portfolio] = [Portfolio(stock: Stock.sampleStocks[0], quantity: 100, date: DateHelper.getDateFromString("2026-04-05"))]
    func buy(stock: Stock, quantity: Int, date: Date = Date()) {
        self.portfolios.append(Portfolio(stock: stock, quantity: quantity, date: date))
    }
    func sell(stock: Stock, quantity: Int, date: Date = Date()) {
        self.portfolios.append(Portfolio(stock: stock, quantity: quantity * -1, date: date))
    }
    
    func getValueDict() -> [String:Double]{
        var res : [String:Double] = [:]
        
        for portfolio in portfolios {
            if var existing = res[portfolio.stock.symbol] {
                existing += Double(portfolio.quantity) * portfolio.stock.getLastPrice()
                res[portfolio.stock.symbol] = existing
            } else {
                res[portfolio.stock.symbol] = Double(portfolio.quantity) * portfolio.stock.getLastPrice()
            }
        }
        return res
    }
    
    func calculatePriceDifferencePercentage(stockSymbol: String) -> Double{
        var res: Double = 0.0
        var sumPrice: Double = 0.0
        var count: Int = 0
        let filteredPortfolios: [Portfolio] = portfolios.filter{$0.stock.symbol == stockSymbol}
        for item in filteredPortfolios{
            sumPrice += item.price * Double(item.quantity)
            count += 1
        }
        print(getExistingProfit())
        res =  filteredPortfolios[0].stock.getLastPrice() - (sumPrice / Double(count))
        print(String(res) + " | " + String(getExistingProfit(stockSymbol: stockSymbol)))
        res = res / getExistingProfit(stockSymbol: stockSymbol)
        
        return res
        
    }
    
    
    func getExistingProfit(stockSymbol: String = "") -> Double{
        var res: Double = 0.0
        var existingStock: [Portfolio] = []
        let filteredPortfolios: [Portfolio] = stockSymbol == "" ? portfolios.filter{$0.stock.symbol == stockSymbol}: portfolios
        for item in filteredPortfolios {
            if item.quantity > 0 {
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
