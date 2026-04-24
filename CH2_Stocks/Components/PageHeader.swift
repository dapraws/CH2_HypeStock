//
//  PageHeader.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 24/04/26.
//

import SwiftUI

struct PageHeader: View {
    let title: String
 
    var body: some View {
        Text(title)
            .font(.system(size: 34, weight: .bold))
            .foregroundColor(.primaryText)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, Spacing.md)
            .padding(.top, Spacing.md)
            .padding(.bottom, Spacing.sm)
    }
}
