//
//  DateFormatter.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/21.
//

import Foundation

func formatDate(date: Date?) -> String {
    guard let date = date else { return "" }
    let formatter = DateFormatter()
    formatter.dateStyle = .medium // Choose a style that suits your needs
    formatter.timeStyle = .none
    return formatter.string(from: date)
}
