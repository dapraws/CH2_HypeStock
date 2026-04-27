//
//  AddPortfolioButtonComponentView.swift
//  CH2_Stocks
//
//  Created by Amadeus on 27/04/26.
//

import SwiftUI

struct AddPortfolioButtonComponentView: View {
    @State var buyFunction: ()->()
    @State var sellFunction: ()->()
    var body: some View {
        Menu{
            Button("Buy"){
                buyFunction()
            }
            Button("Sell"){
                sellFunction()
            }
        }label:{
            ZStack{
                Circle()
                    .foregroundColor(.green)
                    .frame(width: 70, height: 70)
                Image(systemName: "plus")
                    .font(.system(size: 70/2))
                    .bold()
                    .foregroundColor(.white)
            }
        }
        .menuOrder(.fixed)
    }
}

#Preview {
    AddPortfolioButtonComponentView(buyFunction: {print("buy")}, sellFunction: {print("sell")})
}
