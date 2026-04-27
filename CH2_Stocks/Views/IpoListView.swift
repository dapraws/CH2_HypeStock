//
//  IpoListView.swift
//  CH2_Stocks
//
//  Created by Amadeus on 20/04/26.
//

import SwiftUI

struct IpoListView: View {
    private let viewModel = IpoListViewModel()

    var body: some View {
        List {
            ForEach(viewModel.ipos) { ipo in
                IpoRow(ipo: ipo)
                    .listRowBackground(Color.cardBackground)
                    .listRowInsets(EdgeInsets(top: 0, leading: Spacing.md, bottom: 0, trailing: Spacing.md))
            }
        }
        .navigationTitle("Upcoming IPO")
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .navigationBarTitleDisplayMode(.large)
        .toolbar(.hidden, for: .tabBar)
    }
}

struct IpoRow: View {
    let ipo: Ipo

    var body: some View {
        HStack(spacing: Spacing.md) {
            StockLogo(symbol: ipo.symbol, size: 44)

            VStack(alignment: .leading, spacing: 3) {
                Text(ipo.symbol)
                    .font(.appTicker)
                    .foregroundColor(.primaryText)
                Text(ipo.name)
                    .font(.appCaption)
                    .foregroundColor(.secondaryText)
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(moneyFormat(money: ipo.price))
                    .font(.appSubheadline)
                    .foregroundColor(.primaryText)

                HStack(spacing: 3) {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 10))
                    Text(ipo.GetCheckpointDate())
                        .font(.appBadge)
                }
                .foregroundColor(.stockGreen)
            }
        }
        .padding(.vertical, Spacing.sm + 2)
    }
}

#Preview {
    NavigationStack {
        IpoListView()
    }
}
