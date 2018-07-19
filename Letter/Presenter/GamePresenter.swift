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
    func updateCorrectLetters(letter:String)
    func wrongLetterPressed()
}

class GamePresenter {
    var objectModel:ObjectModel
    weak var delegate:GamePresenterDelegate?
    var mainNode:SCNNode?
    var wordArray:[Character]
    
    init(objectModel:ObjectModel, delegate:GamePresenterDelegate) {
        self.objectModel = objectModel
        self.delegate = delegate
        self.wordArray = Array(self.objectModel.name)
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
        if wordArray.count > 0{
            if letter.first == wordArray.first {
                delegate?.updateCorrectLetters(letter: letter)
                self.wordArray.remove(at: 0)
            } else {
                delegate?.wrongLetterPressed()
            }
        }
    }
}
