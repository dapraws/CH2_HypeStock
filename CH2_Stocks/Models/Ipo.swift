//
//  Ipo.swift
//  CH2_Stocks
//
//  Created by Amadeus on 20/04/26.
//

import Foundation

struct Ipo: Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    var price: Double
    var checkpointTime: Date
    
    func GetCheckpointDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: checkpointTime)
    }
}
