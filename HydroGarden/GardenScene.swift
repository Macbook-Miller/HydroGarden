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
        backgroundColor = .clear
        
        // Background sprite //
        let bg = SKSpriteNode(imageNamed: "garden_bg")
        bg.name = "bg"
        bg.position = CGPoint(x: size.width / 2, y: size.height / 2)
        bg.zPosition = -10
        bg.size = size
        bg.texture?.filteringMode = .nearest
        addChild(bg)
        
        // Plant sprite //
        plantNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(plantNode)
        layoutNodes()
    }

    override func didChangeSize(_ oldSize: CGSize) {
        layoutNodes()
    }

    private func layoutNodes() {
        // Resize & center background
        if let bg = childNode(withName: "bg") as? SKSpriteNode {
            bg.size = size
            bg.position = CGPoint(x: size.width / 2, y: size.height / 2)
        }

        // Size the plant relative to scene and move it closer to the bottom
        let side = min(size.width, size.height) * 0.38 // adjust 0.30–0.45 to taste
        plantNode.size = CGSize(width: side, height: side)
        plantNode.position = CGPoint(
            x: size.width / 2,
            y: size.height * 0.40 // lower value moves it closer to the bottom
        )
    }
    
    func render(stage: PlantState.Stage) {
        let textureName: String
        switch stage {
        case .seed:     textureName = "plant_seed"
        case .sprout:   textureName = "plant_sprout"
        case .leafy:    textureName = "plant_leafy"
        case .complete: textureName = "plant_complete"
        }
        let texture = SKTexture(imageNamed: textureName)
        texture.filteringMode = .nearest

        // Swap texture and added a small “pop” animation to make it feel alive.
        plantNode.run(.group([
            .setTexture(texture, resize: false),
            .sequence([
                .scale(to: 1.05, duration: 0.08),
                .scale(to: 1.0, duration: 0.08)
            ])
        ]))
        if plantNode.texture == nil {
            plantNode.texture = texture
        }
    }
    
    
}
