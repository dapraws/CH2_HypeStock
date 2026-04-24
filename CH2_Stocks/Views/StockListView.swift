//
//  StockListView.swift
//  CH2_Stocks
//
//  Created by Amadeus on 21/04/26.
//

import SwiftUI
 
struct StockListView: View {
    @State var stocks: [Stock] = sortedStocks(stockList: Stock.sampleStocks, filter: .all)
    var stockFilter: ListFilter = .all
 
    var listTitle: String {
        switch stockFilter {
        case .mostBuy:          return "Most Buy Stocks"
        case .mostSell:         return "Most Sell Stocks"
        case .mostDividend:     return "Highest Dividend"
        case .influencerChoice: return "Influencer Choice"
        default:                return "Stocks"
        }
    }
 
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
 
                List {
                    ForEach(stocks) { stock in
                        NavigationLink(destination: StockDetailsView(stock: stock)) {
                            StockListRow(stock: stock)
                        }
                        .listRowBackground(Color.cardBackground)
                        .listRowInsets(EdgeInsets(top: 0, leading: Spacing.md, bottom: 0, trailing: Spacing.md))
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle(listTitle)
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            stocks = sortedStocks(stockList: Stock.sampleStocks, filter: stockFilter)
        }
        .onChange(of: stockFilter) { _, newFilter in
            stocks = sortedStocks(stockList: Stock.sampleStocks, filter: newFilter)
        }
    }
}
  
struct StockListRow: View {
    let stock: Stock
 
    var body: some View {
        HStack(spacing: Spacing.md) {
            StockLogo(symbol: stock.symbol, size: 44)
 
            VStack(alignment: .leading, spacing: 3) {
                Text(stock.symbol)
                    .font(.system(size: 15, weight: .bold, design: .monospaced))
                    .foregroundColor(.primaryText)
                Text(stock.name)
                    .font(.system(size: 13))
                    .foregroundColor(.secondaryText)
                    .lineLimit(1)
            }
 
            Spacer()
 
            VStack(alignment: .trailing, spacing: 4) {
                Text(stock.getLastPriceToString())
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primaryText)
                PriceBadge(percentage: stock.getPercentage(), status: stock.getStatus())
            }
        }
        .padding(.vertical, Spacing.sm + 2)
    }
}
 
#Preview {
    StockListView()
}
