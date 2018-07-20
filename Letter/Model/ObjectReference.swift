//
//  ObjectReference.swift
//  Letter
//
//  Created by Giovani Nascimento Pereira on 19/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation

// Model
// reference for all the objects available on the game
// used as a Singleton
class ObjectReference: NSObject {
    
    // Singleton
    static let instance: ObjectReference = ObjectReference()
    
    // All the game Objects
    let objects: [ObjectModel] = [
        ObjectModel(id: "1", name: "aranha", filename:"spider", image: #imageLiteral(resourceName: "Elephant"), hiddenImage: #imageLiteral(resourceName: "hiddenElephant")),
        ObjectModel(id: "2", name: "aranha", filename: "spider", image: #imageLiteral(resourceName: "Elephant"), hiddenImage: #imageLiteral(resourceName: "hiddenElephant")),
        ObjectModel(id: "3", name: "robô", filename: "spider", image: #imageLiteral(resourceName: "robot"), hiddenImage: #imageLiteral(resourceName: "hiddenRobot")),
        ObjectModel(id: "4", name: "aranha", filename: "spider", image: #imageLiteral(resourceName: "Elephant"), hiddenImage: #imageLiteral(resourceName: "hiddenElephant")),
        ObjectModel(id: "5", name: "aranha", filename: "spider", image: #imageLiteral(resourceName: "Elephant"), hiddenImage: #imageLiteral(resourceName: "hiddenElephant")),
        ObjectModel(id: "6", name: "aranha", filename: "spider", image: #imageLiteral(resourceName: "Elephant"), hiddenImage: #imageLiteral(resourceName: "hiddenElephant")),
        ObjectModel(id: "7", name: "aranha", filename: "spider", image: #imageLiteral(resourceName: "Elephant"), hiddenImage: #imageLiteral(resourceName: "hiddenElephant"))
    ]
    
    private override init() {
        super.init()
    }
}
