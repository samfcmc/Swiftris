//
//  Shape.swift
//  Swiftris
//
//  Created by Samuel Coelho on 09/07/15.
//  Copyright (c) 2015 Samuel Coelho. All rights reserved.
//

import SpriteKit

let numOrientations: UInt32 = 4

enum Orientation: Int, Printable {
    case Zero = 0, Ninety, OneEighty, TwoSeventy
    
    var description: String {
        switch self {
        case .Zero:
            return "0"
        case .Ninety:
            return "90"
        case .OneEighty:
            return "180"
        case .TwoSeventy:
            return "270"
        }
    }
    
    static func random() -> Orientation {
        return Orientation(rawValue: Int(arc4random_uniform(numOrientations)))!
    }
    
    static func rotate(orientation: Orientation, clockwise: Bool) -> Orientation {
        var rotated = orientation.rawValue + (clockwise ? 1 : -1)
        
        if rotated > Orientation.TwoSeventy.rawValue {
            rotated = Orientation.Zero.rawValue
        }
        else if rotated < 0 {
            rotated = Orientation.TwoSeventy.rawValue
        }
        return Orientation(rawValue: rotated)!
    }
}

// Number of different shapes
let NumShapeType: UInt32 = 7

let FirstBlockIdx: Int = 0
let SecondBlockIdx: Int = 1
let ThirdBlockIdx:Int = 2
let FourthBlockIdx: Int = 3

class Shape: Hashable, Printable {
    
    let color: BlockColor
    
    var blocks = Array<Block>()
    
    var orientation: Orientation
    var column: Int
    var row: Int
    
    /*
     * Required overrides
     */
    /*
     * Returns a dictionary that maps orientation to an array of tuples
     */
    var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [:]
    }
    
    var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [:]
    }
    
    // No more required overrides
    
    var bottomBlocks: Array<Block> {
        if let bottomBlocks = bottomBlocksForOrientations[orientation] {
            return bottomBlocks
        }
        return []
    }
    
    var hashValue: Int {
        return reduce(blocks, 0) {$0.hashValue ^ $1.hashValue }
    }
    
    var description:String {
        return "\(color) block facing \(orientation): \(blocks[FirstBlockIdx]), \(blocks[SecondBlockIdx]), \(blocks[ThirdBlockIdx]), \(blocks[FourthBlockIdx])"
    }
    
    init(column: Int, row: Int, color: BlockColor, orientation: Orientation) {
        self.column = column
        self.row = row
        self.color = color
        self.orientation = orientation
        initializeBlocks()
    }
    
    /*
     * Convenience initializer: This kind of initializers must
     * call other initializers
     */
    convenience init(column: Int, row: Int) {
        self.init(column: column, row: row, color: BlockColor.random(), orientation: Orientation.random())
    }
    
    final func initializeBlocks() {
        if let blockRowColumnTranslations = blockRowColumnPositions[orientation] {
            for i in 0..<blockRowColumnTranslations.count {
                let blockRow = blockRowColumnTranslations[i].rowDiff
                let blockColumn = blockRowColumnTranslations[i].columnDiff
                let newBlock = Block(column: blockColumn, row: blockRow, color: color)
                blocks.append(newBlock)
            }
        }
    }
}

func ==(lhs: Shape, rhs: Shape) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}
