//
//  ContentView.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/2/28.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        MouthDiagramView()
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}