//
//  PortfolioListView.swift
//  CH2_Stocks
//
//  Created by Amadeus on 23/04/26.
//

import SwiftUI

struct PortfolioListView: View {
    @State var totalProfit: Double = 1_250_000
    @StateObject var portfolioData = PortfolioData()
    let allStocks = Stock.sampleStocks
    
    var bestStock: Stock? {
        allStocks.filter { $0.getStatus() == .up }
            .max(by: { $0.getPercentage() < $1.getPercentage() })
    }
    
    var worstStock: Stock? {
        allStocks.filter { $0.getStatus() == .down }
            .min(by: { $0.getPercentage() < $1.getPercentage() })
    }
    
    var profitText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        let number = formatter.string(from: NSNumber(value: abs(totalProfit))) ?? "0"
        return "Rp\(number)"
    }
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            VStack{
                
                    VStack(spacing: Spacing.lg) {
                        ProfitHeader(profitText: moneyFormat(money: portfolioData.getExistingProfit()), isPositive: totalProfit >= 0)
                        
                        HStack(spacing: Spacing.sm) {
                            if let best = bestStock {
                                StockMiniCard(label: "Best Pick", stock: best, color: .stockGreen)
                            }
                            if let worst = worstStock {
                                StockMiniCard(label: "Worst Pick", stock: worst, color: .stockRed)
                            }
                        }
                    }
                    .padding(.horizontal, Spacing.md)
                    .padding(.bottom, Spacing.xxl)
                
                

                // portfolio list
                List(portfolioData.portfolios){ portfolio in
                    Button{
                        
                    }label: {
                        StockItemComponentView(stockSymbol: portfolio.stock.symbol, stockName: portfolio.stock.name, stockValue: moneyFormat(money:  (portfolioData.getValueDict()[portfolio.stock.symbol] ?? 0)), stockPercentage: percentageFormat(percentage: portfolioData.calculatePriceDifferencePercentage(stockSymbol: portfolio.stock.symbol)), midSymbol: "", stockColor: getIndicatorColor(value: portfolioData.calculatePriceDifferencePercentage(stockSymbol: portfolio.stock.symbol)))
                    }
                }
                .listStyle(.plain)
            }
            
        }
    }
}

#Preview {
    PortfolioListView()
}
