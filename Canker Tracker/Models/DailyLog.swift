//
//  DailyLog.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/4.
//

import Foundation

struct DailyLog: Codable {
    let date: Date
    let activeSoresID: [UUID]
    let currentlySick: Bool
    let sugarUse: Bool
    let spicyFood: Bool
    let caffineUse: Int
    let carbonatedDrinks: Int
    let alcoholicDrinks: Int
    let hoursOfSleep: Int
    let stressLevel: Int
    var notes: String
}
