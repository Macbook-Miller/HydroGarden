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
                        // "Faked" inner shadow
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .strokeBorder(
                                    LinearGradient(
                                        colors: [
                                            Color.black.opacity(0.55), // darker top-left edge
                                            Color.black.opacity(0.20)  // softer bottom-right edge
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 4
                                )
                                .allowsHitTesting(false)
                        )
                        
                        
                        Text("HydroGarden")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                    
                }
                
                
                
                Spacer()
                
                
                Text("Stage: \(String(describing: plant.stage))")
                
                HStack {
                    Button(action: { plant.unWater() }) {
                        Image(systemName: "minus")
                            .font(.title2)
                            .foregroundColor(Color.gray)
                            .frame(width: 80, height: 80)
                    }
                    .buttonStyle(GlossyButtonStyle(shape: Circle(), baseColor: Color.black))
                    
                    Button(action: { plant.water() }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(Color.gray)
                            .frame(width: 80, height: 80)
                    }
                    .buttonStyle(GlossyButtonStyle(shape: Circle(), baseColor: Color.black))
                }
                
                HStack {
                    Text("\(plant.waterCount) / \(plant.waterGoal)")
                    Image(systemName: "drop.fill")
                        .imageScale(.medium)
                        .foregroundStyle(.tint)
                }
                
                VStack {
                    Button(action: {
                        // TODO: Menu sheet on scene
                    }) {
                        Text("")
                            .font(.title2)
                            .frame(width: 80, height: 20)
                        
                    }
                    .background(
                        Capsule()
                            .fill(Color.black)
                    )
                    .buttonStyle(GlossyButtonStyle(shape: Capsule(), baseColor: Color.black))
                    .contentShape(Capsule())
                    
                    Text("MENU")
                }
                
                
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

struct GlossyButtonStyle<S: Shape>: ButtonStyle {
    var shape: S
    var baseColor: Color = .gray
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                shape
                    .fill(
                        LinearGradient(
                            colors: [
                                baseColor.opacity(configuration.isPressed ? 0.9 : 1.0),
                                baseColor.opacity(configuration.isPressed ? 0.6 : 0.8)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        shape.stroke(Color.black.opacity(0.2), lineWidth: 2)
                    )
                    .shadow(color: .black.opacity(0.4), radius: 4, x: 2, y: 2)
                    .shadow(color: .black.opacity(0.6), radius: 3, x: -2, y: -2)
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { _, isPressed in
                if isPressed {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                }
            }
    }
}


#Preview {
    ContentView()
}
