//
//  StringExtension.swift
//  Letter
//
//  Created by Bianca Itiroko on 19/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation

extension String {
    subscript(a: Int) -> String {
        get {
            return String(Array(self)[a])
        }
        set {
            var array = Array(self)
            array[a] = Character(newValue)
            self = String(array)
        }
    }
    
    func character(at a: Int) -> String {
        return String(Array(self)[a])
    }
}
