//
//  IpoListView.swift
//  CH2_Stocks
//
//  Created by Amadeus on 20/04/26.
//

import SwiftUI
 
struct IpoListView: View {
    let ipos: [Ipo] = IpoListViewModel.ipos
 
    var body: some View {
        NavigationStack{
            List {
                ForEach(ipos) { ipo in
                    IpoRow(ipo: ipo)
                        .listRowBackground(Color.cardBackground)
                        .listRowInsets(EdgeInsets(top: 0, leading: Spacing.md, bottom: 0, trailing: Spacing.md))
                }
            }
            .navigationTitle("Upcoming IPsadadadasO")
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .navigationBarTitleDisplayMode(.large)
            .toolbar(.hidden, for: .tabBar)
        }

    }
}
  
struct IpoRow: View {
    let ipo: Ipo
 
    var body: some View {
        HStack(spacing: Spacing.md) {
            StockLogo(symbol: ipo.symbol, size: 44)
 
            VStack(alignment: .leading, spacing: 3) {
                Text(ipo.symbol)
                    .font(.system(size: 15, weight: .bold, design: .monospaced))
                    .foregroundColor(.primaryText)
                Text(ipo.name)
                    .font(.system(size: 13))
                    .foregroundColor(.secondaryText)
                    .lineLimit(1)
            }
 
            Spacer()
 
            VStack(alignment: .trailing, spacing: 4) {
                Text(moneyFormat(money: ipo.price))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primaryText)
 
                HStack(spacing: 3) {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 10))
                    Text("Open now!")
                        .font(.system(size: 12, weight: .semibold))
                }
                .foregroundColor(.stockGreen)
            }
        }
        .padding(.vertical, Spacing.sm + 2)
    }
}
 
#Preview {
    IpoListView()
}
