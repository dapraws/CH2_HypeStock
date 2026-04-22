//
//  ContentView.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 15/04/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }
            Tab("Stocks", systemImage: "chart.line.uptrend.xyaxis") {
                StockListView()
            }
            Tab("Portfolio", systemImage: "briefcase.fill") {
                PlaceholderTab(title: "Portfolio", icon: "briefcase.fill")
            }
            Tab(role: .search) {
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
                    .font(.system(size: 36))
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
