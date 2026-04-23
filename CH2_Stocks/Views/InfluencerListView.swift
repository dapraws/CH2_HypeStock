//
//  InfluencerListView.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 22/04/26.
//

import SwiftUI

struct InfluencerListView: View {
    @State var searchText = ""
    let influencers = Influencer.sampleInfluencers
    var filteredInfluencers: [Influencer] {
        if searchText.isEmpty {
            return influencers
        }
        return influencers.filter { influencer in
            influencer.name.localizedCaseInsensitiveContains(searchText) ||
            influencer.title.localizedCaseInsensitiveContains(searchText)
        }
    }
    var body: some View {
        VStack {
            Text("Best Trader Influencer")
                .frame(maxWidth: .infinity, maxHeight: 120, alignment: .leading)
                .background()
                .font(.system(size: 50))
                .bold()
                .padding(.top, 50)
            List {
                Section {
                    ForEach(Array(filteredInfluencers.enumerated()), id: \.element.id) { index, influencer in
                        NavigationLink(destination: InfluencerDetailView(influencer: influencer)) {
                            InfluencerRow(rank: index + 1, influencer: influencer)
                        }
                        .listRowBackground(Color.appBackground)
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.appBackground)
            .searchable(text: $searchText, prompt: "Search influencers")
        }.ignoresSafeArea()
    }
}

struct InfluencerRow: View {
    let rank: Int
    let influencer: Influencer
    
    var body: some View {
        HStack(spacing: Spacing.md) {
            
            Text("#\(rank)")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondaryText)
                .frame(width: 24, alignment: .center)
            
            AvatarView(initials: influencer.avatarInitials, color: influencer.avatarColor, size: 44)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(influencer.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primaryText)
                Text(influencer.title)
                    .font(.system(size: 13))
                    .foregroundColor(.secondaryText)
                    .lineLimit(1)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 3) {
                Text(influencer.followersText)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primaryText)
                
                Text("followers")
                    .font(.system(size: 11))
                    .foregroundColor(.secondaryText)
            }
        }
        .padding(.vertical, Spacing.xs)
        .background()
    }
}

struct AvatarView: View {
    let initials: String
    let color: Int
    let size: Double
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(hex: color).opacity(0.2))
                .frame(width: size, height: size)
            
            Text(initials)
                .font(.system(size: size * 0.35, weight: .bold, design: .rounded))
                .foregroundColor(Color(hex: color))
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    NavigationStack {
        InfluencerListView()
    }
}

#Preview ("AvatarView") {
    AvatarView(initials: "DP", color: 0xFF3B30, size: 44)
}

#Preview ("InfluencerRow") {
    InfluencerRow(rank: 1, influencer: .sampleInfluencers[0])
}
