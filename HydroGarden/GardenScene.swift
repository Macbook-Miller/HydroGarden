//
//  GardenScene.swift
//  HydroGarden
//
//  Created by Fred on 17/09/2025.
//

import Foundation
import SpriteKit

final class GardenScene: SKScene {
    private let plantNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        backgroundColor = .blue
        plantNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(plantNode)
    }
    
    func render(stage: PlantState.Stage) {
        let textureName: String
        switch stage {
        case .seed:     textureName = "plant_seed"
        case .sprout:   textureName = "plant_sprout"
        case .leafy:    textureName = "plant_seed"
        case .complete: textureName = "plant_sprout"
        }
        let texture = SKTexture(imageNamed: textureName)

        // Swap texture and added a small “pop” animation to make it feel alive.
        plantNode.run(.group([
            .setTexture(texture, resize: true),
            .sequence([
                .scale(to: 1.05, duration: 0.08),
                .scale(to: 1.0, duration: 0.08)
            ])
        ]))
    }
    
    
}
