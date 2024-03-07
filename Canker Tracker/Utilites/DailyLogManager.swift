//
//  DailyLogManager.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/7.
//

import Foundation

struct DailyLogManager {
    
    static func RecordDailyLog(date: Date,
     activeSoresID: [UUID],
     currentlySick: Bool?,
     sugarUse: Bool?,
     spicyFood: Bool?,
     caffineUse: Int?,
     carbonatedDrinks: Int?,
     alcoholicDrinks: Int?,
     hoursOfSleep: Int?,
     stressLevel: Int?,
     notes: String?) {
    var dailyLog = DailyLog(date: date, activeSoresID: activeSoresID, currentlySick: currentlySick, sugarUse: sugarUse, spicyFood: spicyFood, caffineUse: caffineUse, carbonatedDrinks: carbonatedDrinks, alcoholicDrinks: alcoholicDrinks, hoursOfSleep: hoursOfSleep, stressLevel: stressLevel, notes: notes)
        AppDataManager.shared.saveJsonData([dailyLog], fileName: Constants.dailyLogFileName)
    }
    
    static func AddSoreIdToLatestLog(soreID: UUID) {
        var logFiles = AppDataManager.loadJsonData(fileName: Constants.dailyLogFileName, type: [DailyLog].self) ?? []
        
        if !logFiles.isEmpty {
            var lastLog = logFiles.removeLast()
            lastLog.activeSoresID.append(soreID)
            logFiles.append(lastLog)
        } else {
            let newLog = DailyLog(date: Date(), activeSoresID: [soreID], currentlySick: nil, sugarUse: nil, spicyFood: nil, caffineUse: nil, carbonatedDrinks: nil, alcoholicDrinks: nil, hoursOfSleep: nil, stressLevel: nil, notes: nil)
            logFiles.append(newLog)
        }
        
        AppDataManager.shared.saveJsonData(logFiles, fileName: Constants.dailyLogFileName)
    }

    
    static func loadLastLog() -> DailyLog? {
        if let logFiles = AppDataManager.loadJsonData(fileName: Constants.dailyLogFileName, type: [DailyLog].self) {
            return logFiles.last
        }
        else {
            return nil
        }
        
        }
    
    static func loadCurrentSoreIds() -> [UUID] {
        let lastLog = loadLastLog()
        if let currentSoreIds = lastLog?.activeSoresID {
            return currentSoreIds
        } else {
            return []
        }
    }

    static func checkIfDailyLogUpToDate(lastLog: DailyLog?) -> Bool {
        guard let lastLog = lastLog else {
            print("No Daily Log.")
            return false
        }

        let currentDate = Date()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.hour], from: lastLog.date, to: currentDate)
        if let hours = components.hour, hours < 24 {
            print("Daily Log Upto Date.")
            return true
        } else {
            print("Daily Log not Upto Date.")
            return false
        }
    }
}
