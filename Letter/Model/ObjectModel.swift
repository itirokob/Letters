//
//  ObjectModel.swift
//  Letter
//
//  Created by Bianca Itiroko on 19/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation

class ObjectModel {
    var name:String
    var sceneName:String {
        return name + ".scn"
    }
    var nodeName:String{
        return name
    }
    
    init(name:String) {
        self.name = name
    }
}
