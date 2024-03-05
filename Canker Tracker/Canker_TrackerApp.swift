//
//  Canker_TrackerApp.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/2/28.
//

import SwiftUI
import SwiftData

@main
struct Canker_TrackerApp: App {

    var body: some Scene {
        WindowGroup {
            SoreHistoryView(isEditing: false, addNew: false)
        }

    }
}
