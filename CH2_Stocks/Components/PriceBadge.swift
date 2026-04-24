//
//  PriceBadge.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 24/04/26.
//

import SwiftUI

struct PriceBadge: View {
    let percentage: Double
    let status: isStatus
 
    var body: some View {
        Text(String(format: "%.2f%%", percentage))
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.white)
            .padding(.horizontal, 7)
            .padding(.vertical, 3)
            .background(status.color)
            .cornerRadius(6)
    }
}

