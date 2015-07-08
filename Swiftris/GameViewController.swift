//
//  GameViewController.swift
//  Swiftris
//
//  Created by Samuel Coelho on 08/07/15.
//  Copyright (c) 2015 Samuel Coelho. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    /*
     * scene is a variable of type GameScene.
     * Vars are non-optional values. They are required
     * to be instantiated inline or in init.
     * We add the '!' to tell swift that we will instantiate
     * this variable but not in init.
     * We actually do it in viewDidLoad method
     */
    var scene: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        // Create and configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        // Present
        skView.presentScene(scene)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
