//
//  StockListViewModel.swift
//  CH2_Stocks
//
//  Created by Amadeus on 22/04/26.
//

//
//  StockListViewModel.swift
//  CH2_Stocks
//

import Foundation

enum ListFilter {
    case all
    case mostBuy
    case mostSell
    case mostDividend
    case influencerChoice
}


struct StockListViewModel {
    
    let allStocks: [Stock] = [
        Stock(symbol: "APPL", name: "Apple Inc",priceHistory: makePriceHistory(startPrice: 2100),  buyCount: Int.random(in: 1000...99999999), sellCount: Int.random(in: 1000...99999999), lastDividend: Double.random(in: 1...9999)),
        Stock(symbol: "BBCA", name: "Bank Central Asia", priceHistory: makePriceHistory(startPrice: 9500), buyCount: Int.random(in: 1000...99999999), sellCount: Int.random(in: 1000...99999999), lastDividend: Double.random(in: 1...9999)),
        Stock(symbol: "TLKM", name: "Telkom Indonesia", priceHistory: makePriceHistory(startPrice: 3700), buyCount: Int.random(in: 1000...99999999), sellCount: Int.random(in: 1000...99999999), lastDividend: Double.random(in: 1...9999)),
        Stock(symbol: "ASII", name: "Astra International", priceHistory: makePriceHistory(startPrice: 5200), buyCount: Int.random(in: 1000...99999999), sellCount: Int.random(in: 1000...99999999), lastDividend: Double.random(in: 1...9999)),
        Stock(symbol: "BMRI", name: "Bank Mandiri", priceHistory: makePriceHistory(startPrice: 6100),  buyCount: Int.random(in: 1000...99999999), sellCount: Int.random(in: 1000...99999999), lastDividend: Double.random(in: 1...9999)),
        Stock(symbol: "GOTO", name: "GoTo Gojek Tokopedia", priceHistory: makePriceHistory(startPrice: 68), buyCount: Int.random(in: 1000...99999999), sellCount: Int.random(in: 1000...99999999), lastDividend: Double.random(in: 1...9999)),
        Stock(symbol: "BYAN", name: "Bayan Resources", priceHistory: makePriceHistory(startPrice: 22000), buyCount: Int.random(in: 1000...99999999), sellCount: Int.random(in: 1000...99999999), lastDividend: Double.random(in: 1...9999)),
        Stock(symbol: "INDF", name: "Indofood Sukses Makmur", priceHistory: makePriceHistory(startPrice: 7300),  buyCount: Int.random(in: 1000...99999999), sellCount: Int.random(in: 1000...99999999), lastDividend: Double.random(in: 1...9999)),
    ]
    
    func stocks(for filter: ListFilter) -> [Stock] {
        switch filter {
        case .all:
            return allStocks
        case .mostBuy:
            return allStocks.sorted { $0.buyCount > $1.buyCount }
        case .mostSell:
            return allStocks.sorted { $0.sellCount > $1.sellCount }
        case .mostDividend:
            return allStocks.sorted { $0.lastDividend > $1.lastDividend }
        case .influencerChoice:
            let influencerVM = InfluencerListViewModel()
            return allStocks.filter { stock in
                influencerVM.influencers.contains { influencer in
                    influencer.stockChoices.contains { $0.symbol == stock.symbol }
                }
            }
        }
    }
    
    func listTitle(for filter: ListFilter) -> String {
        switch filter {
        case .all:              return "Stocks"
        case .mostBuy:          return "Most Buy Stocks"
        case .mostSell:         return "Most Sell Stocks"
        case .mostDividend:     return "Highest Dividend"
        case .influencerChoice: return "Influencer Choice"
        }
    }
    
    func search(searchString: String) -> [Stock] {
        return allStocks.filter{$0.name.lowercased().contains(searchString.lowercased()) || $0.symbol.lowercased().contains(searchString.lowercased())}
    }
}

func makePriceHistory(startPrice: Double) -> [PriceHistory] {
    var history: [PriceHistory] = []
    var price = startPrice
    for daysAgo in stride(from: 30 * 24, through: 0, by: -1) {
        let date = Calendar.current.date(byAdding: .hour, value: -daysAgo, to: Date()) ?? Date()
        let change = Double.random(in: -startPrice * 0.02 ... startPrice * 0.02)
        price = max(price + change, 1)
        history.append(PriceHistory(date: date, price: price))
    }
    return history
}
