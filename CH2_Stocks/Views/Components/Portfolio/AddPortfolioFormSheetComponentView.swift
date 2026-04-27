//
//  AddPortfolioFormSheetComponentView.swift
//  CH2_Stocks
//
//  Created by Amadeus on 27/04/26.
//

import SwiftUI

struct AddPortfolioFormSheetComponentView: View {
    @State private var stockName: String = "Select Stock"
    @State private var selectedStock: Stock? = nil
    @State private var date: Date = Date()
    @State private var stockQuantity: Int = 0
    @State var isBuy: Bool
    @State var isStockSearchPresented: Bool = false
    @Binding var isFormSheetPresented: Bool
    @ObservedObject var portfolioData: PortfolioData
    var body: some View {
        VStack{
            Text(isBuy ? "Buy" : "Sell")
                .font(.appTitle)
                .padding(20)
            Form{
                LabeledContent("Stock") {
                    Button{
                        isStockSearchPresented.toggle()
                    }label: {
                        Text(stockName)
                            .foregroundColor(stockName == "Select Stock" ? .secondary : .primary)
                    }
                   
                }
                DatePicker("Date", selection: $date, displayedComponents: .date)
                LabeledContent("Qty") {
                    TextField("", value: $stockQuantity, format: .number)
                        .keyboardType(.numberPad)
                }
                Button("Submit"){
                    if (isBuy){
                        portfolioData.buy(stock: selectedStock!, quantity: stockQuantity, date: date)
                    }else{
                        portfolioData.sell(stock: selectedStock!, quantity: stockQuantity, date: date)
                    }
                    isFormSheetPresented = false
                }
            }
        }
        .sheet(isPresented: $isStockSearchPresented){
            AddPortfolioStockSearchComponentView( selectedStock: $selectedStock, stockName: $stockName)
        }
    }
    
    func submitForm(){
        if(isBuy){
            portfolioData.buy(stock: selectedStock!, quantity: stockQuantity, date: date)
        }else{
            portfolioData.sell(stock: selectedStock!, quantity: stockQuantity, date: date)
        }
    }
}

#Preview {
    AddPortfolioFormSheetComponentView(isBuy: true, isFormSheetPresented: .constant(true), portfolioData: PortfolioData())
}
