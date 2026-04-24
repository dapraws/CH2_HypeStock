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
        if searchText.isEmpty { return influencers }
        return influencers.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }
 
    var body: some View {
        List {
            ForEach(Array(filteredInfluencers.enumerated()), id: \.element.id) { index, influencer in
                NavigationLink(destination: InfluencerDetailView(influencer: influencer)) {
                    InfluencerRow(rank: index + 1, influencer: influencer)
                }
                .listRowBackground(Color.cardBackground)
                .listRowInsets(EdgeInsets(top: 0, leading: Spacing.md, bottom: 0, trailing: Spacing.md))
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(Color.appBackground)
        .searchable(text: $searchText, prompt: "Search influencers")
        .navigationTitle("Best Traders")
        .navigationBarTitleDisplayMode(.large)
        .toolbar(.hidden, for: .tabBar)
    }
}
  
struct InfluencerRow: View {
    let rank: Int
    let influencer: Influencer
 
    var body: some View {
        HStack(spacing: Spacing.md) {
            Text("#\(rank)")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .frame(width: 24, alignment: .center)
 
            InfluencerAvatar(
                imageName: influencer.imageName,
                initials: influencer.avatarInitials,
                color: influencer.avatarColor,
                size: 44
            )
 
            VStack(alignment: .leading, spacing: 3) {
                Text(influencer.name)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primaryText)
                Text(influencer.title)
                    .font(.system(size: 13))
                    .foregroundColor(.secondaryText)
                    .lineLimit(1)
            }
 
            Spacer()
 
            VStack(alignment: .trailing, spacing: 2) {
                Text(influencer.followersText)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primaryText)
                Text("followers")
                    .font(.system(size: 11))
                    .foregroundColor(.secondaryText)
            }
        }
        .padding(.vertical, Spacing.sm)
    }
}
 
#Preview {
    NavigationStack {
        InfluencerListView()
    }
}
