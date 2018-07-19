//
//  GamePresenter.swift
//  Letter
//
//  Created by Bianca Itiroko on 19/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation
import ARKit

protocol GamePresenterDelegate: class {
    func instantiateNode(node: SCNNode, lettersNode: SCNNode)
    func updateCorrectLetters(letter:String, index:Int)
    func wrongLetterPressed()
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

        guard let scene = SCNScene(named: objectModel.sceneName),
            let node = scene.rootNode.childNode(withName: objectModel.nodeName, recursively: false)
            else { return }
        node.position = position
        self.mainNode = node
        
        guard let lettersScene = SCNScene(named: "spider.scn"),
            let lettersNode = lettersScene.rootNode.childNode(withName: "sphere", recursively: false)
            else { return }
        lettersNode.position = position
        
        self.delegate?.instantiateNode(node: node, lettersNode: lettersNode)
    }
    
    
    /// This func will be called when the user press a letter, we'll check if it's correct here
    ///
    /// - Parameter letter: letter pressed
    func letterPressed(letter:String){
        let word = self.objectModel.name
        if correctCounter < word.count {
            if letter == word.character(at: correctCounter).uppercased() {
                delegate?.updateCorrectLetters(letter: letter, index: correctCounter)
                correctCounter = correctCounter + 1
            } else {
                delegate?.wrongLetterPressed()
            }
        }
    }
    
    
}


