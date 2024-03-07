//
//  DailyLog.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/4.
//

import Foundation

struct DailyLog: Codable {
    let date: Date
    var activeSoresID: [UUID]
    var currentlySick: Bool?
    var sugarUse: Bool?
    var spicyFood: Bool?
    var caffineUse: Int?
    var carbonatedDrinks: Int?
    var alcoholicDrinks: Int?
    var hoursOfSleep: Int?
    var stressLevel: Int?
    var notes: String?
}
