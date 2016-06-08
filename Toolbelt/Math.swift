//
//  Math.swift
//  Toolbelt
//
//  Created by Chris Chares on 6/2/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

import Foundation
/*
    Multiplication
*/
func *(lhs: Int, rhs: Float) -> Float {
    return Float(lhs) * rhs
}

func *(lhs: Int, rhs: Double) -> Double {
    return Double(lhs) * rhs
}

func *(lhs: Float, rhs: Int) -> Float {
    return lhs * Float(rhs)
}

func *(lhs: Double, rhs: Int) -> Double {
    return lhs * Double(rhs)
}