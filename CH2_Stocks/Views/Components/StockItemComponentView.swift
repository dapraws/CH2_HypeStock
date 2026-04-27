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
                VStack(alignment:.leading, spacing: 10){
                    Text(stockSymbol)
                        .bold()
                    Text(stockName)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                .frame(maxWidth: 150, alignment: .leading)
                Spacer()
                Image(systemName: midSymbol)
                    .frame(alignment: .center)
                    .foregroundColor(stockColor)
                    .font(.system(size: 40))
                    .bold()
                Spacer()
                VStack(alignment:.trailing, spacing: 10){
                    Text(stockValue)
                    Text(stockPercentage)
                        .frame(maxWidth: 90)
                        .background(stockColor.opacity(0.7))
                        .cornerRadius(25)
                }
                .frame(alignment: .trailing)
                .bold()
            }.font(.system(size: 20))
        
    }
}

#Preview {
    StockItemComponentView(stockSymbol: "BBCA", stockName: "BCA", stockValue: moneyFormat(money: 6000), stockPercentage: "20", midSymbol: "", stockColor: Color.red)
}
