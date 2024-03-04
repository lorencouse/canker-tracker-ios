//
//  AppDataManager.swift
//  Canker Tracker
//
//  Created by Loren Couse on 2024/3/2.
//

import Foundation

class AppDataManager {
    static let shared = AppDataManager()
    
    func appendCankerSoreData(_ cankerSore: CankerSore) {
        var soresHistory = AppDataManager.loadFile(fileName: Constants.soreDataFileName, type: [CankerSore].self) ?? []
        soresHistory.append(cankerSore)
        saveCankerSoresData(soresHistory)
    }
    
    func saveCankerSoresData(_ sores: [CankerSore]) {
        let encoder = JSONEncoder()
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath = documentDirectory.appendingPathComponent(Constants.soreDataFileName)
            
            if let encoded = try? encoder.encode(sores) {
                try? encoded.write(to: filePath)
            }
        }
    }
    
    func saveJsonData<T: Codable>(_ objectArray: [T], fileName: String) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Optional: Makes the JSON easier to read.
        
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath = documentDirectory.appendingPathComponent(fileName)
            
            do {
                let encoded = try encoder.encode(objectArray)
                try encoded.write(to: filePath, options: .atomic)
                print("Data saved to \(filePath)")
            } catch {
                print("Failed to save data: \(error.localizedDescription)")
            }
        }
    }
    
    func appendJsonData<T: Codable>(_ newObjects: [T], fileName: String) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Makes the JSON easier to read.
        
        let fileManager = FileManager.default
        if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath = documentDirectory.appendingPathComponent(fileName)
            
            // Attempt to load existing data
            var objectsToSave: [T] = []
            if let data = try? Data(contentsOf: filePath), let existingObjects = try? JSONDecoder().decode([T].self, from: data) {
                objectsToSave.append(contentsOf: existingObjects)
            }
            
            // Append new objects to the loaded data
            objectsToSave.append(contentsOf: newObjects)
            
            // Save the updated array back to the file
            do {
                let encoded = try encoder.encode(objectsToSave)
                try encoded.write(to: filePath, options: .atomic)
                print("Data appended to \(filePath)")
            } catch {
                print("Failed to append data: \(error.localizedDescription)")
            }
        }
    }
    
    func updateCankerSoreData(_ cankerSore: CankerSore, withNewSize newSize: Double, andNewPain newPain: Double) {
        // Load existing sores
        var soresHistory: [CankerSore] = AppDataManager.loadFile(fileName: Constants.soreDataFileName, type: [CankerSore].self) ?? []
        
        // Find the sore to update
        if let index = soresHistory.firstIndex(where: { $0 == cankerSore }) {
            let lastUpdateDate = soresHistory[index].lastUpdated.last ?? Date.distantPast
            let currentDate = Date()
            
            // Check if the last update was on a different day
            let calendar = Calendar.current
            if !calendar.isDate(lastUpdateDate, inSameDayAs: currentDate) {
                // Append new values and date
                soresHistory[index].lastUpdated.append(currentDate)
                soresHistory[index].size.append(newSize)
                soresHistory[index].painLevel.append(newPain)
            } else {
                // Overwrite the most recent values
                soresHistory[index].lastUpdated[soresHistory[index].lastUpdated.count - 1] = currentDate
                soresHistory[index].size[soresHistory[index].size.count - 1] = newSize
                soresHistory[index].painLevel[soresHistory[index].painLevel.count - 1] = newPain
            }
            
            // Save the updated sores array
            saveCankerSoresData(soresHistory)
        }
    }
    
    static func loadFile<T: Decodable>(fileName: String, type: T.Type) -> T? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Documents directory not found.")
            return nil
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Error reading data from file: \(error)")
            return nil
        }
    }
    
    static func deleteFile(fileName: String) {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        guard let fileURL = documentsDirectory?.appendingPathComponent(fileName) else {
            print("Failed to get the file URL")
            return
        }
        
        do {
            try fileManager.removeItem(at: fileURL)
            print("\(fileName) successfully deleted")
        } catch {
            print("Error deleting file: \(error)")
        }
    }
    
}

func saveJsonData<T: Codable>(_ objectArray: [T], fileName: String) {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted // Optional: Makes the JSON easier to read.
    
    if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let filePath = documentDirectory.appendingPathComponent(fileName)
        
        do {
            let encoded = try encoder.encode(objectArray)
            try encoded.write(to: filePath, options: .atomic)
            print("Data saved to \(filePath)")
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
}

func appendJsonData<T: Codable>(_ newObjects: [T], fileName: String) {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted // Makes the JSON easier to read.
    
    let fileManager = FileManager.default
    if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
        let filePath = documentDirectory.appendingPathComponent(fileName)
        
        // Attempt to load existing data
        var objectsToSave: [T] = []
        if let data = try? Data(contentsOf: filePath), let existingObjects = try? JSONDecoder().decode([T].self, from: data) {
            objectsToSave.append(contentsOf: existingObjects)
        }
        
        // Append new objects to the loaded data
        objectsToSave.append(contentsOf: newObjects)
        
        // Save the updated array back to the file
        do {
            let encoded = try encoder.encode(objectsToSave)
            try encoded.write(to: filePath, options: .atomic)
            print("Data appended to \(filePath)")
        } catch {
            print("Failed to append data: \(error.localizedDescription)")
        }
    }
}
