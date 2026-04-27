//
//  InfluencerDetailView.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 22/04/26.
//

import SwiftUI
 
struct InfluencerDetailView: View {
    let influencer: Influencer
 
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
 
            ScrollView {
                VStack(spacing: Spacing.lg) {
                    ProfileCard(influencer: influencer)
                    StatsRow(influencer: influencer)
                    StockPicksSection(stocks: influencer.stockChoices)
                }
                .padding(.horizontal, Spacing.md)
                .padding(.vertical, Spacing.lg)
            }
        }
        .navigationTitle(influencer.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}
 
struct ProfileCard: View {
    let influencer: Influencer
 
    var body: some View {
        VStack(spacing: Spacing.md) {
            InfluencerAvatar(
                imageName: influencer.imageName,
                initials: influencer.avatarInitials,
                color: influencer.avatarColor,
                size: 88
            )
 
            VStack(spacing: Spacing.xs) {
                Text(influencer.name)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.primaryText)
 
                Text(influencer.title)
                    .font(.system(size: 15))
                    .foregroundColor(.secondaryText)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.xl)
        .background(Color.cardBackground)
        .cornerRadius(Radius.xl)
    }
}
  
struct StatsRow: View {
    let influencer: Influencer
 
    var body: some View {
        HStack(spacing: Spacing.sm) {
            StatBox(
                value: influencer.followersText,
                label: "Followers",
                icon: "person.2.fill",
                color: .stockBlue
            )
            StatBox(
                value: "\(influencer.stockPicks)",
                label: "Total Picks",
                icon: "chart.line.uptrend.xyaxis",
                color: .stockGreen
            )
        }
    }
}
 
struct StatBox: View {
    let value: String
    let label: String
    let icon:  String
    let color: Color
 
    var body: some View {
        VStack(spacing: Spacing.xs) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(color)
            Text(value)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.primaryText)
            Text(label)
                .font(.system(size: 11))
                .foregroundColor(.secondaryText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.md)
        .background(Color.cardBackground)
        .cornerRadius(Radius.lg)
    }
}
 
struct StockPicksSection: View {
    let stocks: [Stock]
 
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            SectionHeader(title: "Stock Choice")
 
            VStack(spacing: 0) {
                ForEach(Array(stocks.enumerated()), id: \.element.id) { index, stock in
                    StockPickRow(stock: stock)
                    if index < stocks.count - 1 {
                        Divider().padding(.leading, Spacing.md)
                    }
                }
            }
            .background(Color.cardBackground)
            .cornerRadius(Radius.lg)
        }
    }
}
 
struct StockPickRow: View {
    let stock: Stock
 
    var body: some View {
        HStack(spacing: Spacing.md) {
            StockLogo(symbol: stock.symbol, size: 40)
 
            VStack(alignment: .leading, spacing: 2) {
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
        .padding(.horizontal, Spacing.md)
        .padding(.vertical, Spacing.sm + 2)
    }
}
 
#Preview {
    NavigationStack {
//        InfluencerDetailView(influencer: InfluencerListViewModel().influencers[0])
    }
}
