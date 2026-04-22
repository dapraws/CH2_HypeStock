//
//  StockListView.swift
//  CH2_Stocks
//
//  Created by Amadeus on 21/04/26.
//

import SwiftUI

struct StockListView: View {
    
    @State var listTitle: String = "Stock List"
    @State var stocks: [Stock] = StockListViewModel.stocks
    
    var body: some View {
        NavigationStack{
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
                    NavigationLink{
                        StockDetailsView(stock: stock)
                    }label: {
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
                        
                }
                .frame(maxWidth: .infinity)
                .listStyle(.plain)
            }
            .ignoresSafeArea()
        }
        
    }
}

#Preview {
    StockListView()
}
