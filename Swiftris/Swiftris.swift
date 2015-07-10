//
//  Swiftris.swift
//  Swiftris
//
//  Created by Samuel Coelho on 10/07/15.
//  Copyright (c) 2015 Samuel Coelho. All rights reserved.
//

let NumColumns = 10
let NumRows = 20

// Start location of each shape
let StartingColumn = 4
let StartingRow = 0

let PreviewColumn = 12
let PreviouRow = 1

class Swiftris{
    var blockArray: Array2D<Block>
    var nextShape: Shape?
    var fallingShape: Shape?
    
    init() {
        fallingShape = nil
        nextShape = nil
        blockArray = Array2D<Block>(columns: NumColumns, rows: NumRows)
    }
    
    func beginGame() {
        if nextShape == nil {
            nextShape = Shape.random(StartingColumn, startingRow: StartingRow)
        }
    }
    
    func newShape() -> (fallingShape: Shape?, nextShape: Shape?) {
        fallingShape = nextShape
        nextShape = Shape.random(PreviewColumn, startingRow: PreviouRow)
        fallingShape?.moveTo(StartingColumn, row: StartingRow)
        return (fallingShape, nextShape)
    }
}