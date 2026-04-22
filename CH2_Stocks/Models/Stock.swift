//
//  StockDate.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 17/04/26.
//

import Foundation

struct Stock: Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    let priceHistory: [PriceHistory]
    
    // buyCount
    // sellCount
    //
    
    
    func getOpenPrice() -> Double {
        for i in 0..<priceHistory.count {
            if Calendar.current.isDate(Date(), inSameDayAs: priceHistory[i].date){
                return priceHistory[i].price
            }
        }
        return 0
        
    }
    
    func getLastPrice() -> Double {
        return priceHistory.last!.price
    }
    
    func getPrice() -> Double {
        return priceHistory.last!.price
    }
    
    func getStatus() -> isStatus {
        if getPrice() > getOpenPrice() {
            return .up
        } else if getPrice() < getOpenPrice() {
            return .down
        } else {
            return .neutral
        }
    }
    
    func getPercentage() -> Double {
        return 100 * (getPrice() - getOpenPrice()) / getOpenPrice()
    }
    
}


struct PriceHistory: Identifiable {
    let id = UUID()
    let date: Date
    let price: Double
}

enum isStatus {
    case neutral, up, down
}





