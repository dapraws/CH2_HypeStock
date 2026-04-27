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

    private let viewModel = StockListViewModel()

    var bestStock: Stock? {
        viewModel.allStocks
            .filter { $0.getStatus() == .up }
            .max(by: { $0.getPercentage() < $1.getPercentage() })
    }

    var worstStock: Stock? {
        viewModel.allStocks
            .filter { $0.getStatus() == .down }
            .min(by: { $0.getPercentage() < $1.getPercentage() })
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: Spacing.lg) {

                        ProfitCard(totalProfit: totalProfit)

                        if bestStock != nil || worstStock != nil {
                            VStack(alignment: .leading, spacing: Spacing.sm) {
                                SectionHeader(title: "Today's Picks")
                                HStack(spacing: Spacing.sm) {
                                    if let best = bestStock {
                                        StockMiniCard(label: "Best Pick", stock: best)
                                    }
                                    if let worst = worstStock {
                                        StockMiniCard(label: "Worst Pick", stock: worst)
                                    }
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            SectionHeader(title: "Explore")

                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: Spacing.sm) {

                                NavigationLink(destination: InfluencerListView()) {
                                    MenuItemCard(title: "Best Trader Influencer")
                                }
                                .buttonStyle(.plain)

                                Button {
                                    stockFilter = .influencerChoice
                                    selectedTab = 2
                                } label: {
                                    MenuItemCard(title: "Influencer Stock Choice")
                                }
                                .buttonStyle(.plain)

                                Button {
                                    stockFilter = .mostBuy
                                    selectedTab = 2
                                } label: {
                                    MenuItemCard(title: "Most Buy Stocks")
                                }
                                .buttonStyle(.plain)

                                Button {
                                    stockFilter = .mostSell
                                    selectedTab = 2
                                } label: {
                                    MenuItemCard(title: "Most Sell Stocks")
                                }
                                .buttonStyle(.plain)

                                NavigationLink(destination: IpoListView()) {
                                    MenuItemCard(title: "Upcoming IPO")
                                }
                                .buttonStyle(.plain)

                                Button {
                                    stockFilter = .mostDividend
                                    selectedTab = 2
                                } label: {
                                    MenuItemCard(title: "Highest Dividend")
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(.horizontal, Spacing.md)
                    .padding(.vertical, Spacing.lg)
                }
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
                .font(.appBadge)
                .foregroundColor(.secondaryText)
                .tracking(1.5)

            HStack(alignment: .firstTextBaseline, spacing: Spacing.xs) {
                Text(profitText)
                    .font(.appHeroNumber)
                    .foregroundColor(isPositive ? .stockGreen : .stockRed)
                Image(systemName: isPositive ? "arrow.up.right" : "arrow.down.right")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(isPositive ? .stockGreen : .stockRed)
            }

            Text("Total Profit Today")
                .font(.appCaption)
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

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(label.uppercased())
                .font(.appBadge)
                .foregroundColor(.secondaryText)
                .tracking(0.8)

            HStack(spacing: Spacing.sm) {
                StockLogo(symbol: stock.symbol, size: 36)

                VStack(alignment: .leading, spacing: 2) {
                    Text(stock.symbol)
                        .font(.appTicker)
                        .foregroundColor(.primaryText)
                    Text(stock.name)
                        .font(.appCaption)
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

struct MenuItemCard: View {
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(title)
                .font(.appSubheadline)
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

struct SectionHeader: View {
    let title: String
 
    var body: some View {
        Text(title)
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.primaryText)
    }
}

#Preview {
    ContentView()
}
