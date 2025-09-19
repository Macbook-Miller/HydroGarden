//
//  ContentView.swift
//  HydroGarden
//
//  Created by Fred on 24/08/2025.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    @StateObject private var plant = PlantState()
    @State private var scene: GardenScene = {
        let s = GardenScene()
        s.scaleMode = .resizeFill
        return s
    }()
    
    /*
    init() {
        testPlantReset()
    }
    */
    
    
    
    var body: some View {
        VStack {
            
            SpriteView(scene: scene)
                .ignoresSafeArea(edges: .top)
                .frame(maxHeight: 400)
            
            Image(systemName: "drop.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("HydroGarden")
            
            Text("Stage: \(String(describing: plant.stage))")
            
            Button(action: {
                plant.water()
            }) {
                Text("+ water")
            }
            
            Button(action: {
                plant.unWater()
            }) {
                Text("- water")
            }
            
            Text("\(plant.waterCount)")
            
        }
        .padding()
        .onAppear {
            scene.render(stage: plant.stage)
        }
        .onChange(of: plant.stage) { _, newStage in
            scene.render(stage: newStage)
        }
        
    }
}

#Preview {
    ContentView()
}
