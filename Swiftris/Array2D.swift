//
//  Array2D.swift
//  Swiftris
//  2 dimensions array implementation
//
//  Created by Samuel Coelho on 08/07/15.
//  Copyright (c) 2015 Samuel Coelho. All rights reserved.
//

/*
 * Generic Array2D: This implementation can store anything
 */
class Array2D<T> {
    let columns: Int
    let rows: Int
    
    /*
     * Swift array. T? means that type T is optional
     */
    var array: Array<T?>
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        
        self.array = Array<T?>(count: rows * columns, repeatedValue: nil)
    }
    
    /*
     * subscript: In this case, allows us to do:
     * a = Array2D(lines, columns)
     * c = a[l, c]
     */
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[(row * columns) + column]
        }
        set(newValue) {
            array[(row * columns) + column] = newValue
        }
    }
}

