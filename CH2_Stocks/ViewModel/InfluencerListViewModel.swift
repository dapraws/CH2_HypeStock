//
//  InfluencerListViewModel.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 27/04/26.
//

import Foundation

struct InfluencerListViewModel {

    let allStocks = StockListViewModel().allStocks

    var influencers: [Influencer] {
        [
            Influencer(name: "Budi Hartono",   title: "Macro Economist",             followers: 3200000, stockPicks: 58,  stockChoices: [allStocks[0], allStocks[3], allStocks[7]], avatarInitials: "BH", avatarColor: 0xFF3B30, imageName: "BudiHartono"),
            Influencer(name: "Rizky Pratama",  title: "Certified Financial Analyst", followers: 2400000, stockPicks: 142, stockChoices: [allStocks[0], allStocks[1], allStocks[2]], avatarInitials: "RP", avatarColor: 0x007AFF),
            Influencer(name: "Sari Dewi",      title: "Stock Market Educator",       followers: 1100000, stockPicks: 89,  stockChoices: [allStocks[5], allStocks[6], allStocks[7]], avatarInitials: "SD", avatarColor: 0x34C759),
            Influencer(name: "Andi Kurniawan", title: "Value Investing Advocate",    followers: 875000,  stockPicks: 210, stockChoices: [allStocks[1], allStocks[4], allStocks[6]], avatarInitials: "AK", avatarColor: 0xFF9500),
            Influencer(name: "Maya Santoso",   title: "Day Trader & Content Creator",followers: 560000,  stockPicks: 376, stockChoices: [allStocks[2], allStocks[5]],               avatarInitials: "MS", avatarColor: 0xAF52DE),
        ]
    }

    func filtered(by searchText: String) -> [Influencer] {
        if searchText.isEmpty { return influencers }
        return influencers.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }
}
