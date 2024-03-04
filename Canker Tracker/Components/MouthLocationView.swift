////
////  MouthLocationView.swift
////  Canker Tracker
////
////  Created by Loren Couse on 2024/3/4.
////
//
//import Foundation
//import SwiftUI
//
//class SoreViewModel: ObservableObject {
//    @Published var sores: [CankerSore] = []
//    @Published var selectedSore: CankerSore?
//    
//    // Load existing sores (this method needs to be called when the Edit view appears)
//    func loadExistingSores(for imageName: String) {
//        // Implement loading logic here, for example:
//        sores = AppDataManager.loadFile(fileName: Constants.soreDataFileName, type: [CankerSore].self) ?? []
//    }
//    
//    func updateSore() {
//      
//    }
//    
//    // Add or update a sore
//    func saveSore(_ sore: CankerSore, isNew: Bool) {
//        if isNew {
//            // Add new sore logic here
//            AppDataManager.shared.saveCankerSoreData(sore)
//        } else {
//            // Update existing sore logic here
//            AppDataManager.shared.updateCankerSoreData(sore)
//        }
//    }
//}
