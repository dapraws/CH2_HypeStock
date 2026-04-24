//
//  InfluencerAvatar.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 24/04/26.
//

import SwiftUI

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
                // Fallback: initials circle
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

