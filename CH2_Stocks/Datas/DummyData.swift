//
//  DummyData.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 21/04/26.
//

import Foundation

func makePriceHistory(startPrice: Double) -> [PriceHistory] {
    var history: [PriceHistory] = []
    var price = startPrice
    for daysAgo in stride(from: 30*24, through: 0, by: -1) {
        let date = Calendar.current.date(byAdding: .hour, value: -daysAgo, to: Date()) ?? Date()
        let change = Double.random(in: -startPrice * 0.02 ... startPrice * 0.02)
        price = max(price + change, 1)
        history.append(PriceHistory(date: date, price: price))
    }
    return history
}

extension Stock {
    static let sampleStocks: [Stock] = [
        Stock(symbol: "BBCA", name: "Bank Central Asia",      priceHistory: makePriceHistory(startPrice: 9500)),
        Stock(symbol: "TLKM", name: "Telkom Indonesia",       priceHistory: makePriceHistory(startPrice: 3700)),
        Stock(symbol: "ASII", name: "Astra International",    priceHistory: makePriceHistory(startPrice: 5200)),
        Stock(symbol: "BMRI", name: "Bank Mandiri",           priceHistory: makePriceHistory(startPrice: 6100)),
        Stock(symbol: "GOTO", name: "GoTo Gojek Tokopedia",   priceHistory: makePriceHistory(startPrice: 68)),
        Stock(symbol: "BYAN", name: "Bayan Resources",        priceHistory: makePriceHistory(startPrice: 22000)),
        Stock(symbol: "INDF", name: "Indofood Sukses Makmur", priceHistory: makePriceHistory(startPrice: 7300)),
        Stock(symbol: "UNVR", name: "Unilever Indonesia",     priceHistory: makePriceHistory(startPrice: 2100)),
    ]
}

extension Influencer {
    static let sampleInfluencers: [Influencer] = [
        Influencer(
            name: "Budi Hartono",
            title: "Macro Economist",
            followers: 3200000,
            stockPicks: 58,
            stockChoices: [Stock.sampleStocks[0], Stock.sampleStocks[3], Stock.sampleStocks[7]],
            avatarInitials: "BH",
            avatarColor: 0xFF3B30
        ),
        Influencer(
            name: "Rizky Pratama",
            title: "Certified Financial Analyst",
            followers: 2400000,
            stockPicks: 142,
            stockChoices: [Stock.sampleStocks[0], Stock.sampleStocks[1], Stock.sampleStocks[2]],
            avatarInitials: "RP",
            avatarColor: 0x007AFF
        ),
        Influencer(
            name: "Sari Dewi",
            title: "Stock Market Educator",
            followers: 1100000,
            stockPicks: 89,
            stockChoices: [Stock.sampleStocks[5], Stock.sampleStocks[6], Stock.sampleStocks[7]],
            avatarInitials: "SD",
            avatarColor: 0x34C759
        ),
        Influencer(
            name: "Andi Kurniawan",
            title: "Value Investing Advocate",
            followers: 875000,
            stockPicks: 210,
            stockChoices: [Stock.sampleStocks[1], Stock.sampleStocks[4], Stock.sampleStocks[6]],
            avatarInitials: "AK",
            avatarColor: 0xFF9500
        ),
        Influencer(
            name: "Maya Santoso",
            title: "Day Trader & Content Creator",
            followers: 560000,
            stockPicks: 376,
            stockChoices: [Stock.sampleStocks[2], Stock.sampleStocks[5]],
            avatarInitials: "MS",
            avatarColor: 0xAF52DE
        ),
        Influencer(
            name: "Budi Hartono",
            title: "Macro Economist",
            followers: 3200000,
            stockPicks: 58,
            stockChoices: [Stock.sampleStocks[0], Stock.sampleStocks[3], Stock.sampleStocks[7]],
            avatarInitials: "BH",
            avatarColor: 0xFF3B30
        ),
        Influencer(
            name: "Rizky Pratama",
            title: "Certified Financial Analyst",
            followers: 2400000,
            stockPicks: 142,
            stockChoices: [Stock.sampleStocks[0], Stock.sampleStocks[1], Stock.sampleStocks[2]],
            avatarInitials: "RP",
            avatarColor: 0x007AFF
        ),
        Influencer(
            name: "Sari Dewi",
            title: "Stock Market Educator",
            followers: 1100000,
            stockPicks: 89,
            stockChoices: [Stock.sampleStocks[5], Stock.sampleStocks[6], Stock.sampleStocks[7]],
            avatarInitials: "SD",
            avatarColor: 0x34C759
        ),
        Influencer(
            name: "Andi Kurniawan",
            title: "Value Investing Advocate",
            followers: 875000,
            stockPicks: 210,
            stockChoices: [Stock.sampleStocks[1], Stock.sampleStocks[4], Stock.sampleStocks[6]],
            avatarInitials: "AK",
            avatarColor: 0xFF9500
        ),
        Influencer(
            name: "Maya Santoso",
            title: "Day Trader & Content Creator",
            followers: 560000,
            stockPicks: 376,
            stockChoices: [Stock.sampleStocks[2], Stock.sampleStocks[5]],
            avatarInitials: "MS",
            avatarColor: 0xAF52DE
        ),
        Influencer(
            name: "Budi Hartono",
            title: "Macro Economist",
            followers: 3200000,
            stockPicks: 58,
            stockChoices: [Stock.sampleStocks[0], Stock.sampleStocks[3], Stock.sampleStocks[7]],
            avatarInitials: "BH",
            avatarColor: 0xFF3B30
        ),
        Influencer(
            name: "Rizky Pratama",
            title: "Certified Financial Analyst",
            followers: 2400000,
            stockPicks: 142,
            stockChoices: [Stock.sampleStocks[0], Stock.sampleStocks[1], Stock.sampleStocks[2]],
            avatarInitials: "RP",
            avatarColor: 0x007AFF
        ),
        Influencer(
            name: "Sari Dewi",
            title: "Stock Market Educator",
            followers: 1100000,
            stockPicks: 89,
            stockChoices: [Stock.sampleStocks[5], Stock.sampleStocks[6], Stock.sampleStocks[7]],
            avatarInitials: "SD",
            avatarColor: 0x34C759
        ),
        Influencer(
            name: "Andi Kurniawan",
            title: "Value Investing Advocate",
            followers: 875000,
            stockPicks: 210,
            stockChoices: [Stock.sampleStocks[1], Stock.sampleStocks[4], Stock.sampleStocks[6]],
            avatarInitials: "AK",
            avatarColor: 0xFF9500
        ),
        Influencer(
            name: "Maya Santoso",
            title: "Day Trader & Content Creator",
            followers: 560000,
            stockPicks: 376,
            stockChoices: [Stock.sampleStocks[2], Stock.sampleStocks[5]],
            avatarInitials: "MS",
            avatarColor: 0xAF52DE
        ),
    ]
}
