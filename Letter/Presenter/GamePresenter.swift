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
    func instantiateNode(node: SCNNode)
}

class GamePresenter {
    var objectModel:ObjectModel
    weak var delegate:GamePresenterDelegate?
    var mainNode:SCNNode?
    
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
        
        self.delegate?.instantiateNode(node: node)
    }
}
