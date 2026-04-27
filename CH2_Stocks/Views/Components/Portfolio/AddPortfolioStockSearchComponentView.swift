//
//  StockSearch.swift
//  CH2_Stocks
//
//  Created by Amadeus on 27/04/26.
//

import SwiftUI

struct AddPortfolioStockSearchComponentView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchString: String = ""
    private let viewModel = StockListViewModel()
    @Binding var selectedStock: Stock?
    @Binding var stockName: String
    var body: some View {
        NavigationStack{
            List {
                ForEach(searchString == "" ? viewModel.allStocks : viewModel.search(searchString: searchString)) { stock in
                    Button{
                        selectedStock = stock
                        stockName = selectedStock!.symbol
                        dismiss()
                    }label: {
                        StockListRow(stock: stock)
                    }
                    .listRowBackground(Color.cardBackground)
                    .listRowInsets(EdgeInsets(top: 0, leading: Spacing.md, bottom: 0, trailing: Spacing.md))
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
        }.searchable(text: $searchString, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
    }
}

#Preview {
    AddPortfolioStockSearchComponentView(selectedStock: .constant(nil), stockName: .constant(""))
}
