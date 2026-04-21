//
//  StockListView.swift
//  CH2_Stocks
//
//  Created by Amadeus on 21/04/26.
//

import SwiftUI

struct StockListView: View {
    
    @State var listTitle: String = "Stock List"
    @State var stocks: [Stock] = [
        .init(symbol: "AAPL", name: "Apple Inc.", priceHistory: [
            .init(date: DateHelper.getDateFromString("2026-04-21"), price: 4449550),
            .init(date: DateHelper.getDateFromString("2026-04-20"), price: 4391440),
            .init(date: DateHelper.getDateFromString("2026-04-17"), price: 4383960),
            .init(date: DateHelper.getDateFromString("2026-04-16"), price: 4341970),
            .init(date: DateHelper.getDateFromString("2026-04-15"), price: 4328540),
            .init(date: DateHelper.getDateFromString("2026-04-14"), price: 4370700),
            .init(date: DateHelper.getDateFromString("2026-04-13"), price: 4393990),

            .init(date: DateHelper.getDateFromString("2026-04-10"), price: 4403340),
            .init(date: DateHelper.getDateFromString("2026-04-09"), price: 4353190),
            .init(date: DateHelper.getDateFromString("2026-04-08"), price: 4361010),
            .init(date: DateHelper.getDateFromString("2026-04-07"), price: 4176900),
            .init(date: DateHelper.getDateFromString("2026-04-06"), price: 4359820),
            .init(date: DateHelper.getDateFromString("2026-04-02"), price: 4261050),
            .init(date: DateHelper.getDateFromString("2026-04-01"), price: 4306610),

            .init(date: DateHelper.getDateFromString("2026-03-31"), price: 4200700),
            .init(date: DateHelper.getDateFromString("2026-03-30"), price: 4173670),
            .init(date: DateHelper.getDateFromString("2026-03-27"), price: 4217190),
            .init(date: DateHelper.getDateFromString("2026-03-26"), price: 4263090),
            .init(date: DateHelper.getDateFromString("2026-03-25"), price: 4277200),
            .init(date: DateHelper.getDateFromString("2026-03-24"), price: 4242350),
            .init(date: DateHelper.getDateFromString("2026-03-23"), price: 4254760)
        ])
    ]
    
    var body: some View {
        VStack {
            // header
            Text(listTitle)
                .frame(maxWidth: .infinity, maxHeight: 120, alignment: .center)
                .background(.yellow)
                .font(.system(size: 30))
                .bold()
                .padding(.top, 50)
            
            // List of stocks
            List (stocks){ stock in
                    HStack{
                        VStack(alignment:.leading, spacing: 10){
                            Text(stock.symbol)
                                .bold()
                            Text(stock.name)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                        .frame(maxWidth: 150, alignment: .leading)
                        Spacer()
                        Image(systemName: stock.getStatusSymbol())
                            .frame(alignment: .center)
                            .foregroundColor(stock.getStatusColor())
                            .font(.system(size: 40))
                            .bold()
                        Spacer()
                        VStack(alignment:.trailing, spacing: 10){
                            Text("Rp" + String(stock.getLastPrice()))
                            Text(stock.getPercentageToString() + "%")
                                .frame(maxWidth: 90)
                                .background(stock.getStatusColor().opacity(0.7))
                                .cornerRadius(25)
                        }
                        .frame(alignment: .trailing)
                        .bold()
                    }.font(.system(size: 20))
            }
            .frame(maxWidth: .infinity)
            .listStyle(.plain)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    StockListView()
}
