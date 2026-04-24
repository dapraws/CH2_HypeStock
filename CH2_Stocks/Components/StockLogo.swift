//
//  StockLogo.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 24/04/26.
//

import SwiftUI

struct StockLogo: View {
    let symbol: String
    let size: CGFloat
 
    var body: some View {
        Group {
            if UIImage(named: symbol) != nil {
                Image(symbol)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: size * 0.22))
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: size * 0.22)
                        .fill(Color.surfaceBackground)
                        .frame(width: size, height: size)
                    Text(symbol.prefix(4))
                        .font(.system(size: size * 0.28, weight: .bold, design: .monospaced))
                        .foregroundColor(.secondaryText)
                }
            }
        }
    }
}
