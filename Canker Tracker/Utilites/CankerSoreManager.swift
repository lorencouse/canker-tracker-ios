//
//  CankerSoreManager.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/7.
//

import Foundation

struct CankerSoreManager {
    
    static func loadActiveSores(imageName: String?) -> [CankerSore] {
        let activeSoreIds = DailyLogManager.loadCurrentSoreIds()
        if activeSoreIds.isEmpty {
            return []
        }
        
        guard let allSores = AppDataManager.loadJsonData(fileName: Constants.soreDataFileName, type: [CankerSore].self) else {
            return [] 
        }
        
        let activeSores = allSores.filter { activeSoreIds.contains($0.id) }
        if imageName != nil {
            let activeSoresForImage = activeSores.filter { sore in
                sore.locationImage == imageName
            }
            return activeSoresForImage
        } else {
            print(activeSores)
            return activeSores
        }
        

        
    }
    
    static func deleteSore(soreID: UUID?) {
        
        guard let unwrappedID = soreID else {
            return
        }
        
        var allDailyLogs = AppDataManager.loadJsonData(fileName: Constants.dailyLogFileName, type: [DailyLog].self) ?? []

        var allCankerSores = AppDataManager.loadJsonData(fileName: Constants.soreDataFileName, type: [CankerSore].self) ?? []

        allCankerSores.removeAll { $0.id == unwrappedID }

        AppDataManager.shared.saveJsonData(allCankerSores, fileName: Constants.soreDataFileName)

        for i in 0..<allDailyLogs.count {
            allDailyLogs[i].activeSoresID.removeAll { $0 == unwrappedID }
        }

        AppDataManager.shared.saveJsonData(allDailyLogs, fileName: Constants.dailyLogFileName)
    }

    
    static func overwriteSoreData(_ newSore: CankerSore?) {
        
        guard let unwrappedSore = newSore else {
            return
        }
        
        var allCankerSores: [CankerSore] = AppDataManager.loadJsonData(fileName: Constants.soreDataFileName, type: [CankerSore].self) ?? []
            
        if let index = allCankerSores.firstIndex(where: { $0.id == unwrappedSore.id }) {
            allCankerSores[index] = unwrappedSore
        } else {
            allCankerSores.append(unwrappedSore)
        }
        
        AppDataManager.shared.saveJsonData(allCankerSores, fileName: Constants.soreDataFileName)
        
    }

    
    static func addDailyLogToExistingSore(existingSore: CankerSore, soreSize: Double, painLevel: Double) {
        
        if soreSize == 0 {
//            Sore is healed
            return
        } else {
//            Add new day log to existing sore
            let today = Date()
            var updatedSore = existingSore
            updatedSore.soreSize.append(soreSize)
            updatedSore.painLevel.append(painLevel)
            updatedSore.lastUpdated.append(today)
            overwriteSoreData(updatedSore)
        }
        
    }
    
    
    
    static func calculateScaledCoordinates(selectedLocationX: Double, selectedLocationY: Double, imageName: String) -> [Double] {
        let imageScale = Constants.imageScaleValues
        
        let xScaled = (selectedLocationX * imageScale[imageName]!.scaleX) + imageScale[imageName]!.xOffset
        let yScaled = (selectedLocationY * imageScale[imageName]!.scaleY) + imageScale[imageName]!.yOffset
        return [xScaled, yScaled]
        
    }
    
    static func saveNewCankerSore( id: UUID,
                                    lastUpdated: [Date],
                                    numberOfDays: Int,
                                    healed: Bool,
                                    location: String,
                                    soreSize: Double,
                                    painLevel: Double,
                                    xCoordinateZoomed: Double,
                                    yCoordinateZoomed: Double) {
        
        let scaledCoordinates: [Double] = calculateScaledCoordinates(selectedLocationX: xCoordinateZoomed, selectedLocationY: yCoordinateZoomed, imageName: location)
        
        //            Create new CankerSore object
        let newCankerSore = CankerSore(
            id: id,
            lastUpdated: lastUpdated,
            numberOfDays: numberOfDays,
            locationImage: location,
            soreSize: [soreSize],
            painLevel: [painLevel],
            xCoordinateZoomed: xCoordinateZoomed,
            yCoordinateZoomed: yCoordinateZoomed,
            xCoordinateScaled: scaledCoordinates[0],
            yCoordinateScaled: scaledCoordinates[1]
        )
        
        //            Save CankerSore
        AppDataManager.shared.appendJsonData([newCankerSore], fileName: Constants.soreDataFileName)
        DailyLogManager.AddSoreIdToLatestLog(soreID: id)
        
    }
    

}
