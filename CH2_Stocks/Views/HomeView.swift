//
//  HomeView.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 20/04/26.
//

import SwiftUI

struct HomeView: View {
    @State var totalProfit: Double = 1250000
    @Binding var selectedTab: Int
    @Binding var stockFilter: ListFilter
    
    let allStocks = Stock.sampleStocks
    
    var bestStock: Stock? {
        allStocks.filter { $0.getStatus() == .up }
            .max(by: { $0.getPercentage() < $1.getPercentage() })
    }
    
    var worstStock: Stock? {
        allStocks.filter { $0.getStatus() == .down }
            .min(by: { $0.getPercentage() < $1.getPercentage() })
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: Spacing.lg) {
                    
                    ProfitCard(totalProfit: totalProfit)
                    
                    if bestStock != nil || worstStock != nil {
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            SectionHeader(title: "Today's Picks")
                            HStack(spacing: Spacing.sm) {
                                if let best = bestStock {
                                    StockMiniCard(label: "Best Pick", stock: best, color: .stockGreen)
                                }
                                if let worst = worstStock {
                                    StockMiniCard(label: "Worst Pick", stock: worst, color: .stockRed)
                                }
                            }
                        }
                    }
                    
                    // --- Menu grid ---
                    VStack(alignment: .leading, spacing: Spacing.sm) {
                        SectionHeader(title: "Explore")
                        MenuGrid(selectedTab: $selectedTab, stockFilter: $stockFilter)
                    }
                }
                .padding(.horizontal, Spacing.md)
                .padding(.vertical, Spacing.lg)
                
            }
            .navigationBarHidden(true)
        }
    }
}

struct ProfitCard: View {
    let totalProfit: Double
    
    var isPositive: Bool { totalProfit >= 0 }
    
    var profitText: String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.groupingSeparator = "."
        return "Rp\(f.string(from: NSNumber(value: abs(totalProfit))) ?? "0")"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text("MY PORTFOLIO")
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(.secondaryText)
                .tracking(1.5)
            
            HStack(alignment: .firstTextBaseline, spacing: Spacing.xs) {
                Text(profitText)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(isPositive ? .stockGreen : .stockRed)
                Image(systemName: isPositive ? "arrow.up.right" : "arrow.down.right")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(isPositive ? .stockGreen : .stockRed)
            }
            
            Text("Total Profit Today")
                .font(.system(size: 13))
                .foregroundColor(.secondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.lg)
        .background(Color.cardBackground)
        .cornerRadius(Radius.xl)
    }
}

struct StockMiniCard: View {
    let label: String
    let stock: Stock
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(label.uppercased())
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.secondaryText)
                .tracking(0.8)
            
            HStack(spacing: Spacing.sm) {
                StockLogo(symbol: stock.symbol, size: 36)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(stock.symbol)
                        .font(.system(size: 15, weight: .bold, design: .monospaced))
                        .foregroundColor(.primaryText)
                    Text(stock.name)
                        .font(.system(size: 11))
                        .foregroundColor(.secondaryText)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            PriceBadge(percentage: abs(stock.getPercentage()), status: stock.getStatus())
        }
        .padding(Spacing.md)
        .frame(maxWidth: .infinity, minHeight: 110, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
        .background(Color.cardBackground)
        .cornerRadius(Radius.lg)
    }
}

struct MenuGrid: View {
    @Binding var selectedTab: Int
    @Binding var stockFilter: ListFilter
    
    struct MenuItem: Identifiable {
        let id    = UUID()
        let title: String
        let color: Int
    }
    
    let items: [MenuItem] = [
        MenuItem(title: "Best Trader Influencer", color: 0x007AFF),
        MenuItem(title: "Influencer Stock Choice", color: 0x007AFF),
        MenuItem(title: "Most Buy Stocks", color: 0x007AFF),
        MenuItem(title: "Most Sell Stocks", color: 0x007AFF),
        MenuItem(title: "Upcoming IPO", color: 0x007AFF),
        MenuItem(title: "Highest Dividend", color: 0x007AFF),
    ]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: Spacing.sm) {
            ForEach(items) { item in
                menuButton(for: item)
            }
        }
    }
    
    // Returns the right button type for each menu item
    @ViewBuilder
    func menuButton(for item: MenuItem) -> some View {
        switch item.title {
        case "Best Trader Influencer":
            NavigationLink(destination: InfluencerListView()) {
                MenuItemCard(item: item)
            }.buttonStyle(.plain)
            
        case "Upcoming IPO":
            NavigationLink(destination: IpoListView()) {
                MenuItemCard(item: item)
            }.buttonStyle(.plain)
            
        case "Most Buy Stocks":
            Button {
                stockFilter = .mostBuy
                selectedTab = 2
            } label: {
                MenuItemCard(item: item)
            }.buttonStyle(.plain)
            
        case "Most Sell Stocks":
            Button {
                stockFilter = .mostSell
                selectedTab = 2
            } label: {
                MenuItemCard(item: item)
            }.buttonStyle(.plain)
            
        case "Highest Dividend":
            Button {
                stockFilter = .mostDividend
                selectedTab = 2
            } label: {
                MenuItemCard(item: item)
            }.buttonStyle(.plain)
            
        default:
            MenuItemCard(item: item)
        }
    }
}

struct MenuItemCard: View {
    let item: MenuGrid.MenuItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(item.title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primaryText)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(Spacing.md)
        .frame(maxWidth: .infinity, minHeight: 90, alignment: .leading)
        .background(Color.cardBackground)
        .cornerRadius(Radius.lg)
    }
}



#Preview {
    ContentView()
}
