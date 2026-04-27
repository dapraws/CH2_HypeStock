//
//  StockListView.swift
//  CH2_Stocks
//
//  Created by Amadeus on 21/04/26.
//

import SwiftUI

struct StockListView: View {
    var stockFilter: ListFilter = .all

    private let viewModel = StockListViewModel()

    @State private var stocks: [Stock] = []

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
            .navigationTitle(viewModel.listTitle(for: stockFilter))
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            stocks = viewModel.stocks(for: stockFilter)
        }
        .onChange(of: stockFilter) { _, newFilter in
            stocks = viewModel.stocks(for: newFilter)
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
                    .font(.appTicker)
                    .foregroundColor(.primaryText)
                Text(stock.name)
                    .font(.appCaption)
                    .foregroundColor(.secondaryText)
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(stock.getLastPriceToString())
                    .font(.appSubheadline)
                    .foregroundColor(.primaryText)
                PriceBadge(percentage: stock.getPercentage(), status: stock.getStatus())
            }
        }
        .padding(.vertical, Spacing.sm + 2)
    }
}

struct StockLogo: View {
    let symbol: String
    let size: CGFloat
 
    var body: some View {
        Group {
            if UIImage(named: symbol) != nil {
                Image(symbol)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: size * 0.22))
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: size * 0.22)
                        .fill(Color.surfaceBackground)
                        .frame(width: size, height: size)
                    Text(symbol.prefix(4))
                        .font(.system(size: size * 0.28, weight: .bold, design: .monospaced))
                        .foregroundColor(.secondaryText)
                }
            }
        }
    }
}

struct PriceBadge: View {
    let percentage: Double
    let status: isStatus
 
    var body: some View {
        Text(String(format: "%.2f%%", percentage))
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.white)
            .padding(.horizontal, 7)
            .padding(.vertical, 3)
            .background(status.color)
            .cornerRadius(6)
    }
}


#Preview {
    StockListView()
}
