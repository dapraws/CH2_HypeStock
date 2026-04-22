//
//  Theme.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 22/04/26.
//

import SwiftUI

extension Color {
    static let appBackground     = Color(.systemBackground)
    static let cardBackground    = Color(.secondarySystemBackground)
    static let surfaceBackground = Color(.tertiarySystemBackground)
    static let separatorColor    = Color(.separator)
    
    static let stockGreen   = Color(.systemGreen)
    static let stockRed     = Color(.systemRed)
    static let stockNeutral = Color(.systemGray)
    static let stockYellow  = Color(.systemYellow)
    static let stockBlue    = Color(.systemBlue)
    
    static let primaryText   = Color(.label)
    static let secondaryText = Color(.secondaryLabel)
    static let tertiaryText  = Color(.tertiaryLabel)
    
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

enum Spacing {
    static let xs: Double = 4
    static let sm: Double = 8
    static let md: Double = 16
    static let lg: Double = 24
    static let xl: Double = 32
    static let xxl: Double = 48
}

enum Radius {
    static let sm: Double = 8
    static let md: Double = 12
    static let lg: Double = 16
    static let xl: Double = 20
}

extension isStatus {
    var color: Color {
        switch self {
        case .up:      return .stockGreen
        case .down:    return .stockRed
        case .neutral: return .stockNeutral
        }
    }
    
    var arrowIcon: String {
        switch self {
        case .up:      return "arrow.up"
        case .down:    return "arrow.down"
        case .neutral: return "minus"
        }
    }
}
