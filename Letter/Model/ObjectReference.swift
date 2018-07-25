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
        ObjectModel(id: "1", name: "elefante", filename:"elephant", image: #imageLiteral(resourceName: "Elephant"), hiddenImage: #imageLiteral(resourceName: "hiddenElephant"), textureName: ""),
        ObjectModel(id: "2", name: "alce", filename: "deer", image: #imageLiteral(resourceName: "deer"), hiddenImage: #imageLiteral(resourceName: "hiddenDeer"), textureName: ""),
        ObjectModel(id: "3", name: "robô", filename: "robot", image: #imageLiteral(resourceName: "robot"), hiddenImage: #imageLiteral(resourceName: "hiddenRobot"), textureName: "robotTexture"),
        ObjectModel(id: "4", name: "cachorro", filename: "dog", image: #imageLiteral(resourceName: "dog"), hiddenImage: #imageLiteral(resourceName: "hiddenDog"), textureName: ""),
        ObjectModel(id: "5", name: "urso", filename: "bear", image: #imageLiteral(resourceName: "bear"), hiddenImage: #imageLiteral(resourceName: "hiddenBear"), textureName: ""),
        ObjectModel(id: "6", name: "girafa", filename: "giraffe", image: #imageLiteral(resourceName: "giraffe"), hiddenImage: #imageLiteral(resourceName: "hiddenGiraffe"), textureName: "giraffeTexture"),
        ObjectModel(id: "7", name: "peixe", filename: "fish", image: #imageLiteral(resourceName: "fish"), hiddenImage: #imageLiteral(resourceName: "hiddenfish"), textureName: "fishTexture"),
        ObjectModel(id: "8", name: "ovelha", filename: "sheep", image: #imageLiteral(resourceName: "sheep"), hiddenImage: #imageLiteral(resourceName: "hiddenSheep"), textureName: ""),
        ObjectModel(id: "9", name: "polvo", filename: "octopus", image: #imageLiteral(resourceName: "octopus"), hiddenImage: #imageLiteral(resourceName: "hiddenOctopus"), textureName: "octopusTexture"),
        ObjectModel(id: "10", name: "coruja", filename: "owl", image: #imageLiteral(resourceName: "owl"), hiddenImage: #imageLiteral(resourceName: "hiddenOwl"), textureName: "")
    ]
    
    private override init() {
        super.init()
    }
}
