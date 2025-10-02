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
        
        ZStack {
            Color("retro_gray") 
                .ignoresSafeArea()

            VStack {
                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(Color.black)
                        .frame(height: 450)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                    
                    SpriteView(scene: scene)
                        .ignoresSafeArea(edges: .top)
                        .frame(maxWidth: 300, maxHeight: 350)
                        .cornerRadius(6)
                        .padding(.top, 25)
                    
                    Text("HydroGarden")
                        .font(.headline)
                        .foregroundColor(.gray)
                        
                    
                }
                
                
                
                Spacer()
                
                
                Image(systemName: "drop.fill")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                
                
                Text("Stage: \(String(describing: plant.stage))")
                
                HStack {
                    Button(action: { plant.unWater() }) {
                        Image(systemName: "minus")
                            .font(.title2)
                            .foregroundColor(Color.gray)
                    }
                    .buttonStyle(RetroButtonStyle(baseColor: Color.black))
                    
                    Button(action: { plant.water() }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(Color.gray)
                    }
                    .buttonStyle(RetroButtonStyle(baseColor: Color.black))
                }
                
                Text("\(plant.waterCount)")
            }
            .padding()
        }
        .onAppear {
            scene.render(stage: plant.stage)
        }
        .onChange(of: plant.stage) { _, newStage in
            scene.render(stage: newStage)
        }
    }
        
}

struct RetroButtonStyle: ButtonStyle {
    var baseColor: Color = .gray
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 60, height: 60)
            .background(
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                baseColor.opacity(0.9),
                                baseColor.opacity(0.6)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.black.opacity(0.2), lineWidth: 2)
                    )
                    .shadow(color: .black.opacity(0.4), radius: 4, x: 2, y: 2)
                    .shadow(color: .white.opacity(0.6), radius: 4, x: -2, y: -2)
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: configuration.isPressed)
            .foregroundColor(.black)
        
            // Haptic feedback
            .onChange(of: configuration.isPressed) { _, isPressed in
                if isPressed {
                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                }
            }
                
    }
}


#Preview {
    ContentView()
}
