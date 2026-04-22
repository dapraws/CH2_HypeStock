//
//  HomeView.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 20/04/26.
//

import SwiftUI

struct HomeView: View {
    
    @State var totalProfit: Double = 1_250_000
    
    let allStocks = Stock.sampleStocks
    
    var bestStock: Stock? {
        allStocks.filter { $0.getStatus() == .up }
            .max(by: { $0.getPercentage() < $1.getPercentage() })
    }
    
    var worstStock: Stock? {
        allStocks.filter { $0.getStatus() == .down }
            .min(by: { $0.getPercentage() < $1.getPercentage() })
    }
    
    var profitText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        let number = formatter.string(from: NSNumber(value: abs(totalProfit))) ?? "0"
        return "Rp\(number)"
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: Spacing.lg) {
                        ProfitHeader(profitText: profitText, isPositive: totalProfit >= 0)
                        
                        HStack(spacing: Spacing.sm) {
                            if let best = bestStock {
                                StockMiniCard(label: "Best Pick", stock: best, color: .stockGreen)
                            }
                            if let worst = worstStock {
                                StockMiniCard(label: "Worst Pick", stock: worst, color: .stockRed)
                            }
                        }
                        
                        MenuGrid()
                    }
                    .padding(.horizontal, Spacing.md)
                    .padding(.bottom, Spacing.xxl)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ProfitHeader: View {
    let profitText: String
    let isPositive: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text("MY PORTFOLIO")
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(.secondaryText)
                .tracking(1.5)
            
            HStack(alignment: .firstTextBaseline, spacing: Spacing.xs) {
                Text(profitText)
                    .font(.system(size: 38, weight: .bold, design: .rounded))
                    .foregroundColor(isPositive ? .stockGreen : .stockRed)
                
                Image(systemName: isPositive ? "arrow.up.right" : "arrow.down.right")
                    .font(.system(size: 20, weight: .bold))
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
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(label.uppercased())
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.secondaryText)
                .tracking(0.8)
            
            Text(stock.symbol)
                .font(.system(size: 20, weight: .semibold, design: .monospaced))
                .foregroundColor(.primaryText)
            
            Text(stock.name)
                .font(.system(size: 11))
                .foregroundColor(.secondaryText)
                .lineLimit(1)
            
            Spacer()
            
            HStack(spacing: 3) {
                Image(systemName: stock.getStatus().arrowIcon)
                    .font(.system(size: 10, weight: .bold))
                Text(String(format: "%.2f%%", abs(stock.getPercentage())))
                    .font(.system(size: 11, weight: .semibold))
            }
            .foregroundColor(.white)
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, Spacing.xs)
            .background(color)
            .cornerRadius(Radius.sm)
        }
        .padding(Spacing.md)
        .frame(maxWidth: .infinity, minHeight: 110, alignment: .leading)
        .background(Color.cardBackground)
        .cornerRadius(Radius.lg)
    }
}

struct MenuGrid: View {
    
    struct MenuItem: Identifiable {
        let id    = UUID()
        let title: String
        let icon:  String
        let color: Int
    }
    
    let items: [MenuItem] = [
        MenuItem(title: "Best Trader Influencer", icon: "person.2.fill", color: 0xFFD60A),
        MenuItem(title: "Influencer Stock Choice", icon: "star.fill", color: 0x007AFF),
        MenuItem(title: "Most Buy Stocks", icon: "arrow.up.circle.fill", color: 0x34C759),
        MenuItem(title: "Most Sell Stocks", icon: "arrow.down.circle.fill", color: 0xFF3B30),
        MenuItem(title: "Upcoming IPO", icon: "sparkles", color: 0xAF52DE),
        MenuItem(title: "Highest Dividend", icon: "chart.bar.fill", color: 0xFF9500),
    ]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Explore")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.primaryText)
            
            LazyVGrid(columns: columns, spacing: Spacing.sm) {
                ForEach(items) { item in
                    if item.title == "Best Trader Influencer" {
                        NavigationLink(destination: InfluencerListView()) {
                            MenuItemCard(item: item, hasArrow: true)
                        }
                        .buttonStyle(.plain)
                    } else {
                        MenuItemCard(item: item, hasArrow: false)
                    }
                }
            }
        }
    }
}

struct MenuItemCard: View {
    let item: MenuGrid.MenuItem
    let hasArrow: Bool
    
    var body: some View {
        HStack(spacing: Spacing.sm) {
            Text(item.title)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(.primaryText)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
            
            if hasArrow {
                Image(systemName: "chevron.right")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.tertiaryText)
            }
        }
        .padding(Spacing.md)
        .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
        .background(Color(hex: item.color).opacity(0.15))
        .cornerRadius(Radius.lg)
    }
}

#Preview {
    HomeView()
}
