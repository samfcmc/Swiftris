//
//  Block.swift
//  Swiftris
//
//  Created by Samuel Coelho on 08/07/15.
//  Copyright (c) 2015 Samuel Coelho. All rights reserved.
//
import SpriteKit

// How many colors are available
let NumberOfColors: UInt32 = 6

/*
 * Printable protocol: generate human-readable strings
 */
enum BlockColor: Int, Printable {
    case Blue = 0, Orange, Purple, Red, Teal, Yellow
    
    /*
     * Computed variable.
     * This could be done using a function
     */
    var spriteName: String {
        switch self {
        case .Blue:
            return "blue"
        case .Orange:
            return "orange"
        case .Purple:
            return "purple"
        case .Red:
            return "red"
        case .Teal:
            return "teal"
        case .Yellow:
            return "yellow"
        }
    }
    
    // Adhere to the printable protocol
    var description: String {
        return self.spriteName
    }
    
    static func random() -> BlockColor {
        return BlockColor(rawValue: Int(arc4random_uniform(NumberOfColors)))!
    }
}

class Block: Hashable, Printable {
    /*
     * "A block should not be able to change colors mid-game 
     * unless you decide to make Swiftris: Epileptic Adventures"
     */
    let color: BlockColor
    
    var column: Int
    var row: Int
    var sprite: SKSpriteNode?
    
    var spriteName: String {
        return color.spriteName
    }
    
    /*
     * Required to support Hashable protocol
     */
    var hashValue: Int {
        return self.column ^ self.row
    }
    
    var description: String {
        /*
         * " For a blue block at row 3, column 8,
         * printing that Block will result in: 
         * "blue: [8, 3]". "
         */
        return "\(color): [\(column) \(row)]"
    }
    
    init(column: Int, row: Int, color: BlockColor) {
        self.column = column
        self.row = row
        self.color = color
    }
}

/*
 * To compare two blocks
 */
func ==(lhs: Block, rhs: Block) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
}
