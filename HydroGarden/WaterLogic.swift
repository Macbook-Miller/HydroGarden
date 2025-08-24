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


