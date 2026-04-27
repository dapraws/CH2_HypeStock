//
//  InfluencerListView.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 22/04/26.
//

import SwiftUI

struct InfluencerListView: View {
    @State private var searchText = ""

    private let viewModel = InfluencerListViewModel()

    var body: some View {
        List {
            ForEach(Array(viewModel.filtered(by: searchText).enumerated()), id: \.element.id) { index, influencer in
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
                .font(.appBadge)
                .foregroundColor(.secondaryText)
                .frame(width: 24, alignment: .center)

            InfluencerAvatar(
                imageName: influencer.imageName,
                initials: influencer.avatarInitials,
                color: influencer.avatarColor,
                size: 44
            )

            VStack(alignment: .leading, spacing: 3) {
                Text(influencer.name)
                    .font(.appSubheadline)
                    .foregroundColor(.primaryText)
                Text(influencer.title)
                    .font(.appCaption)
                    .foregroundColor(.secondaryText)
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text(influencer.followersText)
                    .font(.appSubheadline)
                    .foregroundColor(.primaryText)
                Text("followers")
                    .font(.appBadge)
                    .foregroundColor(.secondaryText)
            }
        }
        .padding(.vertical, Spacing.sm)
    }
}

struct InfluencerAvatar: View {
    let imageName: String?
    let initials: String
    let color: Int
    let size: CGFloat
 
    var body: some View {
        Group {
            if let name = imageName, UIImage(named: name) != nil {
                Image(name)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            } else {
                ZStack {
                    Circle()
                        .fill(Color(hex: color).opacity(0.18))
                        .frame(width: size, height: size)
                    Text(initials)
                        .font(.system(size: size * 0.35, weight: .bold, design: .rounded))
                        .foregroundColor(Color(hex: color))
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        InfluencerListView()
    }
}
