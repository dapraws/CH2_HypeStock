//
//  ContentView.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 15/04/26.
//

import SwiftUI
 
struct ContentView: View {
    @State private var selectedTab: Int = 1
    @State private var stockFilter: ListFilter = .all
 
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house.fill", value: 1) {
                HomeView(selectedTab: $selectedTab, stockFilter: $stockFilter)
            }
            Tab("Stocks", systemImage: "chart.line.uptrend.xyaxis", value: 2) {
                StockListView(stockFilter: stockFilter)
            }
            Tab("Portfolio", systemImage: "briefcase.fill", value: 3) {
                PortfolioListView(stockfilter: $stockFilter)
            }
            Tab(value: 4, role: .search) {
                PlaceholderTab(title: "Search", icon: "magnifyingglass")
            }
        }
        .tint(.stockGreen)
    }
}
 
struct PlaceholderTab: View {
    let title: String
    let icon:  String
 
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            VStack(spacing: Spacing.sm) {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(.secondaryText)
                Text(title)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.primaryText)
                Text("Coming soon")
                    .font(.system(size: 14))
                    .foregroundColor(.secondaryText)
            }
        }
    }
}
 
#Preview {
    ContentView()
}

