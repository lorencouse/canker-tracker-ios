//
//  DailyLogView.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/4.
//

import Foundation
import SwiftUI

struct DailyLogView: View {
    
    @State private var soreLogUptoDate: Bool = false
    @State private var date: Date = Date()
    @State private var currentlySick: Bool = false
    @State private var sugarUse: Bool = false
    @State private var spicyFood: Bool = false
    @State private var caffineUse: Int = 0
    @State private var carbonatedDrinks: Int = 0
    @State private var alcoholicDrinks: Int = 0
    @State private var hoursOfSleep: Int = 0
    @State private var stressLevel: Int = 0
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    @State private var notes: String = ""
    @State private var activeSoresID: [UUID] = []
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Have you consumed any of the following today?")) {
                    CustomToggle(boolVariable: $sugarUse, labelText: "Sugar:")
                    CustomToggle(boolVariable: $spicyFood, labelText: "Spicy Foods:")
                    CustomNumberInput(numberSelected: $caffineUse, labelText: "Caffeinated Drinks:")
                    CustomNumberInput(numberSelected: $alcoholicDrinks, labelText: "Alcoholic Drinks:")
                    CustomNumberInput(numberSelected: $carbonatedDrinks, labelText: "Carbonated Drinks:")
                }
                
                CustomToggle(boolVariable: $currentlySick, labelText: "Are you currently sick? ")
                
                VStack {
                    HStack{
                        Text("Additional Notes:")
                        Spacer()
                    }
                    
                    TextField("Extra info...", text: $notes)
                        .font(.system(size: 18))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                CustomButton(buttonLabel: "Finish") {
                    // Call the function directly
                    DailyLogManager.RecordDailyLog(date: date, activeSoresID: activeSoresID, currentlySick: currentlySick, sugarUse: sugarUse, spicyFood: spicyFood, caffineUse: caffineUse, carbonatedDrinks: carbonatedDrinks, alcoholicDrinks: alcoholicDrinks, hoursOfSleep: hoursOfSleep, stressLevel: stressLevel, notes: notes)

                    soreLogUptoDate = true
                }

                NavigationLink(destination: SoreHistoryView(isEditing: false, addNew: false), isActive: $soreLogUptoDate) { EmptyView() }
                
            }
            .navigationTitle("Daily Log for \(dateFormatter.string(from: date))")
            .onAppear {
                activeSoresID = DailyLogManager.loadCurrentSoreIds()
            }
        }
    }
    
}


#Preview {
    DailyLogView()
}
