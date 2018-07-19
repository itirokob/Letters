//
//  InitialScreenReference.swift
//  Letter
//
//  Created by Giovani Nascimento Pereira on 19/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class InitialScreenReference {
    
    static var screens: [InitialScreen] = [
        InitialScreen(name: "savana", button: "redButton"),
        InitialScreen(name: "india", button: "greenButton"),
        InitialScreen(name: "forrest", button: "orangeButton")
    ]
    
    class func getRandomScreen() -> InitialScreen {
        return self.screens[Int(arc4random_uniform(UInt32(self.screens.count)))]
    }
    
}

class InitialScreen {
    var nibName: String
    var buttonName: String
    
    init(name: String, button: String) {
        self.nibName = name
        self.buttonName = button
    }
}
