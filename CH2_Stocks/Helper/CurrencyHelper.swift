//
//  CurrencyHelper.swift
//  CH2_Stocks
//
//  Created by Amadeus on 23/04/26.
//

import Foundation

func moneyFormat(money: Double) -> String{
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    numberFormatter.currencyCode = "IDR"
    return numberFormatter.string(from: NSNumber(floatLiteral: money)) ?? "Rp0.00"
}
