//
//  StockDetailsView.swift
//  CH2_Stocks
//
//  Created by Amadeus on 22/04/26.
//

import SwiftUI
 
struct StockDetailsView: View {
    let stock: Stock
 
    private let influencerVM = InfluencerListViewModel()
 
    var endorsingInfluencers: [Influencer] {
        influencerVM.influencers.filter { influencer in
            influencer.stockChoices.contains { $0.symbol == stock.symbol }
        }
    }
 
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
 
            ScrollView {
                VStack(spacing: Spacing.md) {
                    StockHeaderCard(stock: stock)
                    BuySellPressureCard(stock: stock)
                    SignalBanner(stock: stock)
                    InfluencerEndorsementCard(influencers: endorsingInfluencers)
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
 
struct StockHeaderCard: View {
    let stock: Stock
 
    var body: some View {
        VStack(spacing: Spacing.md) {
            HStack(spacing: Spacing.md) {
                StockLogo(symbol: stock.symbol, size: 52)
 
                VStack(alignment: .leading, spacing: 4) {
                    Text(stock.symbol)
                        .font(.appTicker)
                        .foregroundColor(.primaryText)
                    Text(stock.name)
                        .font(.appCaption)
                        .foregroundColor(.secondaryText)
                }
 
                Spacer()
 
                PriceBadge(percentage: stock.getPercentage(), status: stock.getStatus())
            }
 
            Divider()
 
            HStack(alignment: .firstTextBaseline, spacing: Spacing.sm) {
                Text(stock.getLastPriceToString())
                    .font(.appPrice)
                    .foregroundColor(.primaryText)
 
                Spacer()
 
                HStack(spacing: 4) {
                    Image(systemName: stock.getStatusSymbol())
                        .font(.system(size: 14, weight: .bold))
                    Text("\(stock.getPercentageToString())%")
                        .font(.appSubheadline)
                }
                .foregroundColor(stock.getStatusColor())
            }
        }
        .padding(Spacing.lg)
        .background(Color.cardBackground)
        .cornerRadius(Radius.xl)
    }
}
 
struct SignalBanner: View {
    let stock: Stock
 
    var signal: Signal {
        let total = Double(stock.buyCount + stock.sellCount)
        guard total > 0 else { return .watch }
        let buyRatio = Double(stock.buyCount) / total
        if buyRatio >= 0.6 { return .buy }
        if buyRatio <= 0.4 { return .avoid }
        return .watch
    }
 
    enum Signal {
        case buy, avoid, watch
 
        var label: String {
            switch self {
            case .buy:   return "BUY SIGNAL"
            case .avoid: return "AVOID"
            case .watch: return "WATCH"
            }
        }
 
        var icon: String {
            switch self {
            case .buy:   return "flame.fill"
            case .avoid: return "xmark.shield.fill"
            case .watch: return "eye.fill"
            }
        }
 
        var color: Color {
            switch self {
            case .buy:   return .stockGreen
            case .avoid: return .stockRed
            case .watch: return .stockYellow
            }
        }
 
        var description: String {
            switch self {
            case .buy:   return "Most traders are buying right now. High demand."
            case .avoid: return "Sell pressure is high. Many traders are exiting."
            case .watch: return "Market is mixed. Watch before jumping in."
            }
        }
    }
 
    var body: some View {
        HStack(spacing: Spacing.md) {
            Image(systemName: signal.icon)
                .font(.system(size: 28))
                .foregroundColor(signal.color)
 
            VStack(alignment: .leading, spacing: 4) {
                Text(signal.label)
                    .font(.appSubheadline)
                    .foregroundColor(signal.color)
                Text(signal.description)
                    .font(.appCaption)
                    .foregroundColor(.secondaryText)
            }
 
            Spacer()
        }
        .padding(.vertical, Spacing.md)
        .padding(.horizontal, Spacing.lg)
        .background(signal.color.opacity(0.1))
        .cornerRadius(Radius.xl)
        .overlay(
            RoundedRectangle(cornerRadius: Radius.xl)
                .stroke(signal.color.opacity(0.3), lineWidth: 1)
        )
    }
}
  
struct BuySellPressureCard: View {
    let stock: Stock
 
    var total: Double { Double(stock.buyCount + stock.sellCount) }
 
    var buyFraction: Double {
        guard total > 0 else { return 0.5 }
        return Double(stock.buyCount) / total
    }
 
    var sellFraction: Double { 1.0 - buyFraction }
 
    func formatCount(_ count: Int) -> String {
        if count >= 1000000 { return String(format: "%.1fM", Double(count) / 1_000_000) }
        if count >= 1000     { return String(format: "%.0fK", Double(count) / 1_000) }
        return "\(count)"
    }
 
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Buy vs Sell Pressure")
                .font(.appHeadline)
                .foregroundColor(.primaryText)
 
            GeometryReader { geo in
                HStack(spacing: 3) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.stockGreen)
                        .frame(width: geo.size.width * buyFraction)
 
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.stockRed)
                        .frame(width: geo.size.width * sellFraction)
                }
            }
            .frame(height: 28)
 
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Label("Buy", systemImage: "arrow.up.circle.fill")
                        .font(.appCaption)
                        .foregroundColor(.stockGreen)
                    Text(formatCount(stock.buyCount))
                        .font(.appSubheadline)
                        .foregroundColor(.primaryText)
                    Text(String(format: "%.0f%%", buyFraction * 100))
                        .font(.appBadge)
                        .foregroundColor(.secondaryText)
                }
 
                Spacer()
 
                VStack(alignment: .trailing, spacing: 2) {
                    Label("Sell", systemImage: "arrow.down.circle.fill")
                        .font(.appCaption)
                        .foregroundColor(.stockRed)
                    Text(formatCount(stock.sellCount))
                        .font(.appSubheadline)
                        .foregroundColor(.primaryText)
                    Text(String(format: "%.0f%%", sellFraction * 100))
                        .font(.appBadge)
                        .foregroundColor(.secondaryText)
                }
            }
        }
        .padding(Spacing.lg)
        .background(Color.cardBackground)
        .cornerRadius(Radius.xl)
    }
}
 
struct InfluencerEndorsementCard: View {
    let influencers: [Influencer]
 
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Text("Influencer Picks")
                    .font(.appHeadline)
                    .foregroundColor(.primaryText)
                Spacer()
                Text("\(influencers.count) endorsing")
                    .font(.appBadge)
                    .foregroundColor(.secondaryText)
            }
 
            if influencers.isEmpty {
                HStack(spacing: Spacing.sm) {
                    Image(systemName: "person.slash")
                        .foregroundColor(.secondaryText)
                    Text("No influencers recommend this stock yet.")
                        .font(.appCaption)
                        .foregroundColor(.secondaryText)
                }
            } else {
                VStack(spacing: 0) {
                    ForEach(Array(influencers.enumerated()), id: \.element.id) { index, influencer in
                        HStack(spacing: Spacing.md) {
                            InfluencerAvatar(
                                imageName: influencer.imageName,
                                initials: influencer.avatarInitials,
                                color: influencer.avatarColor,
                                size: 36
                            )
 
                            VStack(alignment: .leading, spacing: 2) {
                                Text(influencer.name)
                                    .font(.appBody)
                                    .foregroundColor(.primaryText)
                                Text(influencer.title)
                                    .font(.appCaption)
                                    .foregroundColor(.secondaryText)
                            }
 
                            Spacer()
 
                            Text(influencer.followersText)
                                .font(.appBadge)
                                .foregroundColor(.secondaryText)
                        }
                        .padding(.vertical, Spacing.sm)
 
                        if index < influencers.count - 1 {
                            Divider()
                        }
                    }
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
                .font(.appCaption)
                .foregroundColor(.stockBlue)
 
            Text("\(moneyFormat(money: stock.lastDividend)) / unit")
                .font(.appPrice)
                .foregroundColor(.primaryText)
 
            Text("Passive income per lot you hold.")
                .font(.appCaption)
                .foregroundColor(.secondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.lg)
        .background(Color.cardBackground)
        .cornerRadius(Radius.xl)
    }
}
 
#Preview {
    NavigationStack {
        StockDetailsView(stock: StockListViewModel().allStocks[0])
    }
}
