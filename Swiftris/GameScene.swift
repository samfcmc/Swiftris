//
//  GameScene.swift
//  Swiftris
//
//  Created by Samuel Coelho on 08/07/15.
//  Copyright (c) 2015 Samuel Coelho. All rights reserved.
//

import SpriteKit

/*
 * Constant that represents the slowest speed at
 * which our shapes will travel
 */
let TickLengthLevelOne = NSTimeInterval(600)

class GameScene: SKScene {
    
    /* 
     * This is a closure that takes no arguments
     * and returns nothing.
     * (similar to lambdas in other languages)
     */
    var tick: ( ()->() )?
    
    var tickLengthMillis = TickLengthLevelOne
    var lastTick: NSDate?
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supported")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0, y: 1.0)
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 0, y: 0)
        background.anchorPoint = anchorPoint
        addChild(background)
    }
       
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if lastTick == nil {
            return
        }
        var timePassed = lastTick!.timeIntervalSinceNow * -1000.0
        if timePassed > tickLengthMillis {
            lastTick = NSDate()
            
            /*
             * similar to:
             *
             * if tick != nil {
             *   tick!()
             * }
             */
            tick?()
        }
    }
    
    func startTicking() {
        lastTick = NSDate()
    }
    
    func stopTicking() {
        lastTick = nil
    }
}
