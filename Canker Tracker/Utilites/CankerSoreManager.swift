//
//  CankerSoreManager.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/7.
//

import Foundation

struct CankerSoreManager {
    
    static func loadActiveSores(activeSoreIds: [UUID]) -> [CankerSore] {
        //        let activeSoreIds = DailyLogManager.loadCurrentSoreIds()
        
        if activeSoreIds.isEmpty {
            return []
        }
        
        guard let allSores = AppDataManager.loadJsonData(fileName: Constants.soreDataFileName, type: [CankerSore].self) else {
            return [] 
        }
        
        let activeSores = allSores.filter { activeSoreIds.contains($0.id) }
        print(activeSores)
        return activeSores
        
    }
    
    
    static func updateSoreData(_ newSore: CankerSore, fileName: String) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let fileManager = FileManager.default
        if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath = documentDirectory.appendingPathComponent(fileName)
            
            var soresToUpdate: [CankerSore] = []
            if let data = try? Data(contentsOf: filePath), let existingSores = try? JSONDecoder().decode([CankerSore].self, from: data) {
                soresToUpdate = existingSores
            }
            
            if let index = soresToUpdate.firstIndex(where: { $0.id == newSore.id }) {
                soresToUpdate[index] = newSore
            } else {
                soresToUpdate.append(newSore)
            }
            
            do {
                let encoded = try encoder.encode(soresToUpdate)
                try encoded.write(to: filePath, options: .atomic)
                print("Sore data updated in \(filePath)")
            } catch {
                print("Failed to update sore data: \(error.localizedDescription)")
            }
        }
    }
    
    
    private func calculateScaledCoordinates(selectedLocationX: Double, selectedLocationY: Double, imageName: String) -> [Double] {
        let imageScale = Constants.imageScaleValues
        
        let xScaled = (selectedLocationX * imageScale[imageName]!.scaleX) + imageScale[imageName]!.xOffset
        let yScaled = (selectedLocationY * imageScale[imageName]!.scaleY) + imageScale[imageName]!.yOffset
        return [xScaled, yScaled]
        
    }
    
    private func saveNewCankerSore( id: UUID,
                                    lastUpdated: [Date],
                                    numberOfDays: Int,
                                    healed: Bool,
                                    location: String,
                                    size: Double,
                                    painLevel: Double,
                                    xCoordinateZoomed: Double,
                                    yCoordinateZoomed: Double,
                                    xCoordinate: Double,
                                    yCoordinate: Double) {
        
        let scaledCoordinates: [Double] = calculateScaledCoordinates(selectedLocationX: xCoordinateZoomed, selectedLocationY: yCoordinateZoomed, imageName: location)
        
        //            Create new CankerSore object
        
        
        let newCankerSore = CankerSore(
            id: id,
            lastUpdated: lastUpdated,
            numberOfDays: numberOfDays,
            healed: healed,
            location: location,
            soreSize: [size],
            painLevel: [painLevel],
            xCoordinateZoomed: xCoordinateZoomed,
            yCoordinateZoomed: yCoordinateZoomed,
            xCoordinate: scaledCoordinates[0],
            yCoordinate: scaledCoordinates[1]
        )
        
        //            Save CankerSore
        AppDataManager.shared.appendJsonData([newCankerSore], fileName: Constants.soreDataFileName)
        DailyLogManager.AddSoreIdToLatestLog(soreID: id)
        
    }
    
    static func overwriteSoreData() {
        
    }
}
