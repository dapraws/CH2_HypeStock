//
//  IpoListViewModel.swift
//  CH2_Stocks
//
//  Created by Amadeus on 22/04/26.
//


import Foundation

struct IpoListViewModel {

    let ipos: [Ipo] = [
        Ipo(symbol: "WBSA", name: "BSA Logistic Indonesia Tbk.",   price: 150,   checkpointTime: Date()),
        Ipo(symbol: "PTRO", name: "Petrosea Tbk.",                 price: 2450,  checkpointTime: Date().addingTimeInterval(86400 * 3)),
        Ipo(symbol: "BREN", name: "Barito Renewables Energy Tbk.", price: 8750,  checkpointTime: Date().addingTimeInterval(86400 * 7)),
        Ipo(symbol: "CUAN", name: "Petrindo Jaya Kreasi Tbk.",     price: 12500, checkpointTime: Date().addingTimeInterval(86400 * 14)),
    ]
}
