//
//  Influencer.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 17/04/26.
//

import SwiftUI

struct Influencer: Identifiable {
    let id = UUID()
    
    let name: String
    let title: String
    
    var followers: Int
    var stockPicks: Int
    var stockChoices: [Stock]
    
    var avatarInitials: String
    var avatarColor: Int
    
    var followersText: String {
        if followers >= 1000000 {
            return String(format: "%.1fM", Double(followers) / 1000000)
        } else if followers >= 1000 {
            return String(format: "%.0fK", Double(followers) / 1000)
        }
        return "\(followers)"
    }
}
