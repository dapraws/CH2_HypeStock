//
//  IpoListView.swift
//  CH2_Stocks
//
//  Created by Amadeus on 20/04/26.
//

import SwiftUI

struct IpoListView: View {
    
    let ipos: [Ipo] = [
        .init(symbol: "WBSA", name: "BSA Logistic Indonesia Tbk.", price: 150.00, checkpointTime: Date()),
        .init(symbol: "WBSA", name: "BSA Logistic Indonesia Tbk.", price: 150.00, checkpointTime: Date()),
        .init(symbol: "WBSA", name: "BSA Logistic Indonesia Tbk.", price: 150.00, checkpointTime: Date()),
        .init(symbol: "WBSA", name: "BSA Logistic Indonesia Tbk.", price: 150.00, checkpointTime: Date()),
    ]
    
    var body: some View {
        VStack {
            Text("Upcoming IPO")
                .frame(maxWidth: .infinity, maxHeight: 120, alignment: .center)
                .background(.yellow)
                .font(.system(size: 30))
                .bold()
                .padding(.top, 50)
            List (ipos){ ipo in
                    HStack{
                        VStack(alignment:.leading, spacing: 10){
                            Text(ipo.symbol)
                                .bold()
                            Text(ipo.name)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                        .frame(maxWidth: 150, alignment: .leading)
                        Spacer()
                        VStack(alignment:.trailing, spacing: 10){
                            Text(ipo.GetCheckpointDate())
                                .bold()
                            Text("Rp" + String(ipo.price))
                        }
                        .frame(alignment: .trailing)
                    }.font(.system(size: 20))
            }
            .frame(maxWidth: .infinity)
            .listStyle(.plain)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    IpoListView()
}
