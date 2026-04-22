//
//  DateHelper.swift
//  CH2_Stocks
//
//  Created by Amadeus on 21/04/26.
//

import Foundation

struct DateHelper{
    
    // convert string of date to actual date value
    static func getDateFromString(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString) ?? Date()
    }
}
