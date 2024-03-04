////
////  MouthLocationView.swift
////  Canker Tracker
////
////  Created by Loren Couse on 2024/3/4.
////

import Foundation
import SwiftUI

class SoreViewModel: ObservableObject {
    @Published var sores: [CankerSore] = []
    var selectedSore: CankerSore?


    func loadExistingSores(for imageName: String) {
        let allSores = AppDataManager.loadFile(fileName: Constants.soreDataFileName, type: [CankerSore].self) ?? []
        sores = allSores.filter { $0.location == imageName }
    }

    func updateCankerSore(_ sore: CankerSore, newSize: Double, newPain: Double) {
        if let existingIndex = sores.firstIndex(where: { $0.id == sore.id }) {
            sores[existingIndex] = sore
            AppDataManager.shared.updateCankerSoreData(sore, withNewSize: newSize, andNewPain: newPain)
        } else {
            sores.append(sore)
            AppDataManager.shared.saveCankerSoreData(sore)
        }
    }
}
