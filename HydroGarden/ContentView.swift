//
//  ContentView.swift
//  HydroGarden
//
//  Created by Fred on 24/08/2025.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        testPlantReset()
    }
    
    @StateObject private var plant = PlantState()
    
    var body: some View {
        VStack {
            Image(systemName: "drop.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("HydroGarden test!")
            
            Button(action: {
                plant.water()
            }) {
                Text("Log water")
            }
            
            Text("\(plant.waterCount)")
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
