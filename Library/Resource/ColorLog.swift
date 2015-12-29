//
//  ColorLog.swift
//  sctong
//
//  Created by   himi on 15/12/29.
//  Copyright © 2015年 mmmm. All rights reserved.
//

import Foundation

struct ColorLog {
    static let ESCAPE = "\u{001b}["
    
    static let RESET_FG = ESCAPE + "fg;" // Clear any foreground color
    static let RESET_BG = ESCAPE + "bg;" // Clear any background color
    static let RESET = ESCAPE + ";"   // Clear any foreground or background color
    
    static func red<T>(object: T) {
        print("\(ESCAPE)fg255,0,0;\(object)\(RESET)")
    }
    
    static func green<T>(object: T) {
        print("\(ESCAPE)fg0,255,0;\(object)\(RESET)")
    }
    
    static func blue<T>(object: T) {
        print("\(ESCAPE)fg0,0,255;\(object)\(RESET)")
    }
    
    static func yellow<T>(object: T) {
        print("\(ESCAPE)fg255,255,0;\(object)\(RESET)")
    }
    
    static func purple<T>(object: T) {
        print("\(ESCAPE)fg255,0,255;\(object)\(RESET)")
    }
    
    static func cyan<T>(object: T) {
        print("\(ESCAPE)fg0,255,255;\(object)\(RESET)")
    }
}