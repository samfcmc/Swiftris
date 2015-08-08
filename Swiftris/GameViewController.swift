//
//  GameViewController.swift
//  Swiftris
//
//  Created by Samuel Coelho on 08/07/15.
//  Copyright (c) 2015 Samuel Coelho. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, SwiftrisDelegate {
    
    /*
     * scene is a variable of type GameScene.
     * Vars are non-optional values. They are required
     * to be instantiated inline or in init.
     * We add the '!' to tell swift that we will instantiate
     * this variable but not in init.
     * We actually do it in viewDidLoad method
     */
    var scene: GameScene!
    var swiftris: Swiftris!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        // Create and configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        scene.tick = didTick
        
        swiftris = Swiftris()
        swiftris.delegate = self
        swiftris.beginGame()
        // Present
        skView.presentScene(scene)
        
    }
    
    func didTick() {
        swiftris.letShapeFall()
    }
    
    func nextShape() {
        let newShapes = swiftris.newShape()
        if let fallingShape = newShapes.fallingShape {
            self.scene.addPreviewShapeToScene(newShapes.nextShape!, completion: {})
            self.scene.movePreviewShape(fallingShape, completion: {
                self.view.userInteractionEnabled = true
                self.scene.startTicking()
            })
        }
    }
    
    func gameDidBegin(swiftris: Swiftris) {
        if swiftris.nextShape != nil && swiftris.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(swiftris.nextShape!, completion: {
                self.nextShape()
            })
        } else {
            nextShape()
        }
    }
    
    func gameDidEnt(swiftris: Swiftris) {
        view.userInteractionEnabled = false
        scene.stopTicking()
    }
    
    func gameDidLevelUp(swiftris: Swiftris) {
        // Nothing to do...
    }
    
    func gameShapeDidDrop(swiftris: Swiftris) {
        // Nothing to do...
    }
    
    func gameShapeDidLand(swiftris: Swiftris) {
        scene.stopTicking()
        nextShape()
    }
    
    func gameShapeDidMove(swiftris: Swiftris) {
        scene.redrawShape(swiftris.fallingShape!, completion: {})
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
