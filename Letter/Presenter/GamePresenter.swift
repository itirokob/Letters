//
//  GamePresenter.swift
//  Letter
//
//  Created by Bianca Itiroko on 19/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation
import ARKit

// Shake Action - wrong letter pressed
let offset: CGFloat = 0.1
let shakeAction: SCNAction = SCNAction.sequence([SCNAction.moveBy(x: offset, y: 0, z: 0, duration: 0.1), SCNAction.moveBy(x: -offset, y: 0, z: 0, duration: 0.1), SCNAction.moveBy(x: offset, y: 0, z: 0, duration: 0.1), SCNAction.moveBy(x: -offset, y: 0, z: 0, duration: 0.1), SCNAction.moveBy(x: offset, y: 0, z: 0, duration: 0.1), SCNAction.moveBy(x: -offset, y: 0, z: 0, duration: 0.1)])

protocol GamePresenterDelegate: class {
    /// If a plane is detected, we'll instantiate the object and the letters
    func instantiate3DModel(node: SCNNode, lettersNode: SCNNode)
    
    func instantiateNodes(nodes: [SCNNode])
    
    /// When user hits the correct letter, we'll update the display of letters in the screen
    func updateCorrectLetters(letter:String, index:Int, nodePressed: SCNNode)
    
    /// When a wrong letter is pressed, we'll send a feedback to the user
    func wrongLetterPressed()
    
    /// When the player got all the letters correct
    func endGame()
}

class GamePresenter {
    var objectModel:ObjectModel
    weak var delegate:GamePresenterDelegate?
    var mainNode:SCNNode?
    var correctCounter:Int = 0
    
    init(objectModel:ObjectModel, delegate:GamePresenterDelegate) {
        self.objectModel = objectModel
        self.delegate = delegate
    }
    
    /// This func runs the logic of creating a node when a plane is detected, only once
    ///
    /// - Parameter position: position to create the node
    func foundPlane(position: SCNVector3){
        if self.mainNode != nil {
            return
        }
        //Primeiro deve aparecer a pata
        
        //Se houver clique na pata, instanciar o modelo 3D
        self.instantiate3DModel(position: position)
        
    }
    
    func instantiatePaw(position: SCNVector3) {
        
    }
    
    func instantiate3DModel(position: SCNVector3){
        guard let scene = SCNScene(named: objectModel.sceneName),
            let node = scene.rootNode.childNode(withName: objectModel.nodeName, recursively: false)
            else { return }
        node.position = position
        self.mainNode = node
        
        guard let lettersScene = SCNScene(named: "spider.scn"),
            let lettersNode = lettersScene.rootNode.childNode(withName: "sphere", recursively: false)
            else { return }
        lettersNode.position = position
        
        self.delegate?.instantiate3DModel(node: node, lettersNode: lettersNode)
    }
    
    /// This func will be called when the user press a letter, we'll check if it's correct here
    ///
    /// - Parameter letter: letter pressed
    func letterPressed(letter:String, nodePressed:SCNNode){
        let word = self.objectModel.name
        if correctCounter < word.count {
            if letter == word.character(at: correctCounter).uppercased() {
                delegate?.updateCorrectLetters(letter: letter, index: correctCounter, nodePressed: nodePressed)
                correctCounter = correctCounter + 1
                if correctCounter == word.count {
                    delegate?.endGame()
                }
            } else {
                nodePressed.runAction(shakeAction)
                delegate?.wrongLetterPressed()
            }
        }
    }
}


