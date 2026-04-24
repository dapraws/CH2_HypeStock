//
//  StockDetailsView.swift
//  CH2_Stocks
//
//  Created by Amadeus on 22/04/26.
//

import SwiftUI
 
struct StockDetailsView: View {
    @State var stock: Stock
 
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
 
            ScrollView {
                VStack(spacing: Spacing.lg) {
                    StockIdentityCard(stock: stock)
                    StockPriceCard(stock: stock)
                    BuyVsSellCard(stock: stock)
                    DividendCard(stock: stock)
                }
                .padding(.horizontal, Spacing.md)
                .padding(.vertical, Spacing.lg)
            }
        }
        .navigationTitle(stock.symbol)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}
  
struct StockIdentityCard: View {
    let stock: Stock
 
    var body: some View {
        HStack(spacing: Spacing.md) {
            StockLogo(symbol: stock.symbol, size: 56)
 
            VStack(alignment: .leading, spacing: 4) {
                Text(stock.symbol)
                    .font(.system(size: 22, weight: .bold, design: .monospaced))
                    .foregroundColor(.primaryText)
                Text(stock.name)
                    .font(.system(size: 15))
                    .foregroundColor(.secondaryText)
            }
 
            Spacer()
        }
        .padding(Spacing.lg)
        .background(Color.cardBackground)
        .cornerRadius(Radius.xl)
    }
}
  
struct StockPriceCard: View {
    let stock: Stock
 
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text("Current Price")
                .font(.system(size: 13))
                .foregroundColor(.secondaryText)
 
            HStack(alignment: .firstTextBaseline, spacing: Spacing.sm) {
                Text(stock.getLastPriceToString())
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.primaryText)
 
                HStack(spacing: 4) {
                    Image(systemName: stock.getStatusSymbol())
                        .font(.system(size: 14, weight: .bold))
                    Text("\(stock.getPercentageToString())%")
                        .font(.system(size: 15, weight: .semibold))
                }
                .foregroundColor(stock.getStatusColor())
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.lg)
        .background(Color.cardBackground)
        .cornerRadius(Radius.xl)
    }
}
 
struct VsBar: View {
    let buyCount: Int
    let sellCount: Int
 
    var body: some View {
        HStack(spacing: 3) {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.stockGreen)
                .frame(maxWidth: CGFloat(buyCount), maxHeight: 28)
 
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.stockRed)
                .frame(maxWidth: CGFloat(sellCount), maxHeight: 28)
        }
        .frame(maxWidth: .infinity, minHeight: 28, maxHeight: 28)
    }
}
 
 
struct BuyVsSellCard: View {
    let stock: Stock
 
    var total: Double {
        Double(stock.buyCount + stock.sellCount)
    }
 
    var buyFraction: Double {
        guard total > 0 else { return 0.5 }
        return Double(stock.buyCount) / total
    }
 
    var sellFraction: Double {
        1.0 - buyFraction
    }
 
    func formatCount(_ count: Int) -> String {
        if count >= 1000000 {
            return String(format: "%.1fM", Double(count) / 1_000_000)
        } else if count >= 1000 {
            return String(format: "%.0fK", Double(count) / 1_000)
        }
        return "\(count)"
    }
 
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
 
            Text("Buy vs Sell")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primaryText)
 
            VsBar(buyCount: stock.buyCount, sellCount: stock.sellCount)
 
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Label("Buy", systemImage: "arrow.up.circle.fill")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.stockGreen)
                    Text(formatCount(stock.buyCount))
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.primaryText)
                    Text(String(format: "%.0f%%", buyFraction * 100))
                        .font(.system(size: 12))
                        .foregroundColor(.secondaryText)
                }
 
                Spacer()
 
                VStack(alignment: .trailing, spacing: 2) {
                    Label("Sell", systemImage: "arrow.down.circle.fill")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.stockRed)
                    Text(formatCount(stock.sellCount))
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.primaryText)
                    Text(String(format: "%.0f%%", sellFraction * 100))
                        .font(.system(size: 12))
                        .foregroundColor(.secondaryText)
                }
            }
        }
        .padding(Spacing.lg)
        .background(Color.cardBackground)
        .cornerRadius(Radius.xl)
    }
}
  
struct DividendCard: View {
    let stock: Stock
 
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Label("Last Dividend", systemImage: "banknote.fill")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.stockBlue)
 
            Text("\(moneyFormat(money: stock.lastDividend)) / unit")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(.primaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.lg)
        .background(Color.cardBackground)
        .cornerRadius(Radius.xl)
    }
}
 
#Preview {
    NavigationStack {
        StockDetailsView(stock: Stock.sampleStocks[0])
    }
}
