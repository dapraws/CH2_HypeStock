//
//  StockDetailsView.swift
//  CH2_Stocks
//
//  Created by Amadeus on 22/04/26.
//

import SwiftUI

struct StockDetailsView: View {
    
    @State var stock: Stock = .init(symbol: "AAPL", name: "Apple Inc.", priceHistory: [.init(date: DateHelper.getDateFromString("2026-04-10"), price: 4403340)])
    
    var body: some View {
        VStack(spacing: 0){
            // header
            Text(stock.symbol)
                .frame(maxWidth: .infinity, maxHeight: 120, alignment: .center)
                .background(.yellow)
                .font(.system(size: 30))
                .bold()
                .padding(.top, 50)
            Image(systemName: stock.getStatusSymbol())
                .font(Font.system(size: 80))
                .frame(maxWidth: .infinity, maxHeight: 169)
                .foregroundColor(stock.getStatusColor())
                .bold()
            Divider()
            Text(stock.getLastPriceToString())
                .font(Font.system(size: 30))
                .frame(maxWidth: .infinity, maxHeight: 111)
                .bold()
            HStack(spacing:0){
                VStack{
                    Text("Buy")
                        .frame(maxHeight: 115.5/2)
                    Divider()
                    Text("123")
                        .frame(maxHeight: 115.5/2)
                }
                .frame(maxWidth: .infinity)
                .background(.red)
                VStack{
                    Text("Sell")
                        .frame(maxHeight: 115.5/2)
                    Divider()
                    Text("123")
                        .frame(maxHeight: 115.5/2)
                }
                .frame(maxWidth: .infinity)
                .background(.green)
            }
            .font(.system(size: 20))
            .bold()
            VStack{
                Text("Last Dividend")
                    .frame(maxHeight: 115.5/2)
                Divider()
                Text("100 / unit")
                    .frame(maxHeight: 115.5/2)
            }
            .frame(maxWidth: .infinity)
            .background(.yellow)
            .font(.system(size: 20))
            .bold()
            .shadow(radius: 16, x: 0, y: 8)
            
            Spacer()
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    StockDetailsView()
}
