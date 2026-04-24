//
//  StylePickerHelper.swift
//  CH2_Stocks
//
//  Created by Amadeus on 24/04/26.
//

import SwiftUI

func getIndicatorColor(value: Double) -> Color{
    if(value > 0) {
        return Color.green
    }else if (value < 0) {
        return Color.red
    } else {
        return Color.gray
    }
}
