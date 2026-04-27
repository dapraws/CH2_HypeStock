//
//  StockItemComponentView.swift
//  CH2_Stocks
//
//  Created by Amadeus on 24/04/26.
//

import SwiftUI

struct StockItemComponentView: View {
    let stockSymbol: String
    let stockName: String
    let stockValue: String
    let stockPercentage: String
    let midSymbol: String
    let stockColor: Color
    var body: some View {
            HStack{
                StockLogo(symbol: stockSymbol, size: 44)

                VStack(alignment: .leading, spacing: 3) {
                    Text(stockSymbol)
                        .font(.appTicker)
                        .foregroundColor(.primaryText)
                    Text(stockName)
                        .font(.appCaption)
                        .foregroundColor(.secondaryText)
                        .lineLimit(1)
                }
                .frame(width: 60)
                
                Spacer()
                
                VStack(spacing: 4) {
                    HStack{
                        Spacer()
                        Text(stockValue)
                            .font(.appSubheadline)
                            .foregroundColor(.primaryText)
                    }
                    PriceBadge(percentage: 2.1, status: .up)
                }
            }
            .padding(.vertical, Spacing.sm)
        
    }
}

#Preview {
    VStack{
        StockItemComponentView(stockSymbol: "BBCA", stockName: "BCA", stockValue: moneyFormat(money: 6000), stockPercentage: "20", midSymbol: "", stockColor: Color.red)
    }
}
