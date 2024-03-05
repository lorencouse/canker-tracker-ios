////
////  MouthLocationView.swift
////  Canker Tracker
////
////  Created by Loren Couse on 2024/3/4.
////

//import Foundation
//import SwiftUI
//
//
//
//
//class SoreViewModel: ObservableObject {
//    @Published var sores: [CankerSore] = []
//    var selectedSore: CankerSore?
//
//
//    func loadExistingSores(for imageName: String, healed: Bool? = nil) {
//        let allSores = AppDataManager.loadJsonData(fileName: Constants.soreDataFileName, type: [CankerSore].self) ?? []
//        // Filter sores based on location and optionally by healed status
//        sores = allSores.filter { sore in
//            let matchesLocation = sore.location == imageName
//            if let healedStatus = healed {
//                return matchesLocation && sore.healed == healedStatus
//            }
//            return matchesLocation
//        }
//    }
//
//    func updateCankerSore(_ sore: CankerSore, newSize: Double, newPain: Double) {
//        if let existingIndex = sores.firstIndex(where: { $0.id == sore.id }) {
//            sores[existingIndex] = sore
//            AppDataManager.shared.updateCankerSoreData(sore, withNewSize: newSize, andNewPain: newPain)
//        } else {
//            sores.append(sore)
//            AppDataManager.shared.appendCankerSore(sore)
//        }
//    }
//}
