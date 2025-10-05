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
    private let wateringCanNode = SKSpriteNode(imageNamed: "watering1")
    private let wateringFrames: [SKTexture] = {
        let names = ["watering1", "watering2"]
        let textures = names.map { SKTexture(imageNamed: $0) }
        textures.forEach { $0.filteringMode = .nearest }
        return textures
    }()
    private var isWateringPlaying = false
    
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
        
        // Watering Can sprite
        wateringCanNode.position = CGPoint(
            x: size.width / 2 - 15, // SEcond value moves the watering can left in the scene
            y: size.height * 0.65 // above the plant node
        )
        wateringCanNode.zPosition = 5
        wateringCanNode.isHidden = true
        wateringCanNode.texture?.filteringMode = .nearest
        addChild(wateringCanNode)
        
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
        let delay = SKAction.wait(forDuration: 0.05)
        let changeTexture = SKAction.group([
            .setTexture(texture, resize: false),
            .sequence([
                .scale(to: 1.05, duration: 0.08),
                .scale(to: 1.0, duration: 0.08)
            ])
        ])
        
        plantNode.run(.sequence([delay, changeTexture]))
        
        if plantNode.texture == nil {
            plantNode.texture = texture
        }
    }
    
    func showWateringCan() {
        wateringCanNode.removeAllActions()
        isWateringPlaying = true
        wateringCanNode.isHidden = false
        wateringCanNode.alpha = 0
        
        let animate = SKAction.animate(with: wateringFrames, timePerFrame: 0.15)
        let totalDuration: Double = 2.0
        let frameDuration = 0.15
        let cycleDuration = frameDuration * Double(wateringFrames.count)
        let cycles = max(1, Int(ceil(totalDuration / cycleDuration)))
        let loop = SKAction.repeat(animate, count: cycles)
        
        let appear = SKAction.fadeIn(withDuration: 0.2)
        let wait = SKAction.wait(forDuration: 0.0)
        let disappear = SKAction.fadeOut(withDuration: 0.3)
        let finish = SKAction.run { [weak self] in
            self?.wateringCanNode.removeAllActions()
            self?.wateringCanNode.isHidden = true
            self?.isWateringPlaying = false
        }
        
        wateringCanNode.run(.sequence([
            .group([loop, appear]),
            wait,
            disappear,
            finish
        ]))
        
        
    }
    
    
}
