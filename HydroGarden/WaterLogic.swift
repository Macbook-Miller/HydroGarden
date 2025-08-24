//
//  WaterLogic.swift
//  HydroGarden
//
//  Created by Fred on 24/08/2025.
//

import Foundation

// MARK: - Plant Growth System (Logic Outline)

// This file handles the plant growth logic for HydroGarden.

// - The plant goes through several visual stages during a day.
// - The user sets a daily water goal (e.g., 8 glasses).
// - Each time the user drinks a glass, they press a button to "water" the plant.
// - The plant grows to the next stage every (goal / number of stages) waters.
// - If the user completes the goal, the plant reaches its final stage and they earn points.
// - If not, the plant is reset the next day.
// - We need to track:
//   - How many waters today
//   - What the current stage is
//   - What the daily goal is
//   - If the plant is fully grown
//   - Points earned (if goal completed)
//   - Date of last plant (for reset)
// - The data should be saved locally on the device (e.g., using UserDefaults for now).


class PlantState: ObservableObject {
    
    var userPoints: Int = 0
    
    enum Stage {
        case seed, sprout, leafy, complete
    }
    
    @Published var waterCount: Int = 0
    var stage: Stage = .seed
    var datePlanted: Date = Date()
    var waterGoal: Int = 8
    var fullyGrown: Bool = false
    
    func water() {
        waterCount += 1
        
        let stageProgress: Double = Double(waterCount) / Double(waterGoal)
        
        if stageProgress < 0.33 {
            stage = .seed
        } else if stageProgress >= 0.33 && stageProgress < 0.66 {
            stage = .sprout
        } else if stageProgress <= 1.0 {
            stage = .leafy
        }
        
        if waterCount >= waterGoal {
            fullyGrown = true
            stage = .complete
            userPoints += 10
        }
        
    }
    
    // compare datePlanted with the current date, if they are not the same, reset all the stats
    func resetIfNeeded() {
        let toDay = Date()
        
        // Compare only the day/month/year of toDay and datePlanted
        // If they are different, reset plan
        if Calendar.current.isDate(datePlanted, inSameDayAs: toDay) == false {
            waterCount = 0
            stage = .seed
            datePlanted = toDay
            fullyGrown = false
        }
    }
    
}

func testPlantReset() {
    let yesterday = Calendar.current.date(byAdding: .day, value:-1, to: Date())!
    let plant = PlantState()
    plant.datePlanted = yesterday
    plant.waterCount = 3
    plant.fullyGrown = true
    
    plant.resetIfNeeded()
    
    print("== Plant Reset Test ==")
    print("Water count:", plant.waterCount)
    print("Stage:", plant.stage)
    print("Fully grown:", plant.fullyGrown)
    print("Date planted:", plant.datePlanted)
}
