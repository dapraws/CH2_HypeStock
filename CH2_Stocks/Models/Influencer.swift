//
//  Influencer.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 17/04/26.
//

import Foundation

struct Influencer: Identifiable {
    let id: UUID = UUID()
    let name: String
    let title: String
    var followers: Int
    var stockChoices: [Stock]
    
}
