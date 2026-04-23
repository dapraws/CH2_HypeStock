//
//  Portfolio.swift
//  CH2_Stocks
//
//  Created by Amadeus on 23/04/26.
//

import Foundation

struct Portfolio: Identifiable {
    let id: UUID = UUID()
    let stock: Stock
    let quantity: Int
    let date: Date
    var price: Double{
        return stock.priceHistory.min(by: { $0.date < $1.date })?.price ?? 0
    }
}
