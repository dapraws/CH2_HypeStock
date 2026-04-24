//
//  StockDate.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 17/04/26.
//

import Foundation
import SwiftUI

struct Stock: Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    let priceHistory: [PriceHistory]
    var buyCount: Int = 0
    var sellCount: Int = 0
    var lastDividend: Double = 0
    var imageName: String { symbol }
    
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
    
    
    func getStatusColor() -> Color{
            switch getStatus() {
            case .up:
                return .green
            case .down:
                return .red
            case .neutral:
                return .gray
            }
        }
        
        func getStatusSymbol() -> String{
            switch getStatus() {
            case .up:
                return "arrow.up"
            case .down:
                return "arrow.down"
            case .neutral:
                return "minus"
            }
        }
        
        func getPercentage() -> Double {
            if(getOpenPrice() == 0){
                return 0
            }
            return 100 * (getPrice() - getOpenPrice()) / getOpenPrice()
        }
        
        func getPercentageToString() -> String{
            
            let percentageFormatter = NumberFormatter()
            percentageFormatter.roundingMode = .down
            percentageFormatter.maximumFractionDigits = 2
            return percentageFormatter.string(for: getPercentage())!
        }
    
        func getLastPriceToString() -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.currencyCode = "IDR"
            return numberFormatter.string(from: NSNumber(floatLiteral: getLastPrice())) ?? "Rp0.00"
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





