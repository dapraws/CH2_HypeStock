//
//  SectionHeader.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 24/04/26.
//

import SwiftUI

struct SectionHeader: View {
    let title: String
 
    var body: some View {
        Text(title)
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.primaryText)
    }
}
