//
//  ContentView.swift
//  CH2_Stocks
//
//  Created by Muhammad Darrel Prawira on 15/04/26.
//

import SwiftUI
import Charts

struct SalesData: Identifiable {
    let id = UUID()
    let month: String
    let amount: Int
}

let data: [SalesData] = [
    .init(month: "Jan", amount: 10),
    .init(month: "Feb", amount: 15),
    .init(month: "Mar", amount: 8),
    .init(month: "Apr", amount: 12),
    .init(month: "May", amount: 18),
    .init(month: "Jun", amount: 20),
    .init(month: "Jul", amount: 10),
    .init(month: "Aug", amount: 14),
    .init(month: "Sep", amount: 16),
    .init(month: "Oct", amount: 13),
    .init(month: "Nov", amount: 19),
    .init(month: "Dec", amount: 17),
]
struct StockData: Identifiable {
    let id = UUID()
    let symbol: String
    let name: String
    let price: Double
}
let stockData: [String: Double] = [
    "Apple": 280.00,
    "Google": 2700.00,
    "Facebook": 350.00,
    "Alphabet": 2300.00,
    "Tesla": 700.00,
]

struct MyChartView: View {
    var body: some View {
        Chart(data) { datum in
            AreaMark(
                x: .value("Month", datum.month),
                y: .value("Sales", datum.amount)
            )
            .foregroundStyle(.blue)
        }
        .frame(height: 300)
        .padding()
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List{
                StockCard()
                
            }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack{
                            Text("Stocks").font(Font.largeTitle.bold()).frame(width: 200, alignment: .leading)
                            Text("15 April").font(Font.subheadline)
                                .frame(width: 200, alignment: .leading)
                        }
                    }.sharedBackgroundVisibility(Visibility.hidden)
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack{
                            Button(action: { /*Search here...*/ }) {
                                Image(systemName: "magnifyingglass")
                            }
                            Button(action: { /*more here...*/ }) {
                                Image(systemName: "ellipsis")
                            }
                        }
                    }
                }
        }
        

    }
}

#Preview {
    ContentView()
}

struct StockCard: View {
    var body: some View {
        HStack{
            //1
            VStack{
                Text("Title")// Title
                Text("Subtitle")// Subtitle
            }
            Spacer()
            
            //2
            HStack{
                MyChartView()
                
                VStack{
                    Text("Price")// Price
                    Button(action: { }) {
                        Text("421").padding().background(Color.green)
                    }// Percentage
                }
            }
            // Charts here...
            
        
            
        }
    }
}
