//
//  ViewController.swift
//  Letter
//
//  Created by Bianca Itiroko on 18/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import SpriteKit

class ViewController: UIViewController, ARSCNViewDelegate, GamePresenterDelegate {
    @IBOutlet var sceneView: ARSCNView!
    var objectModel:ObjectModel?
    var presenter:GamePresenter?
    var sight: SKSpriteNode?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/empty.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        //Check if we have a object model already
        if self.objectModel == nil {
            self.objectModel = ObjectReference.instance.objects[0]
        }
        
        //Instantiate game presenter
        if let object = self.objectModel {
            self.presenter = GamePresenter(objectModel: object, delegate: self)
        }
        
        //Initiate the sight
        sceneView.overlaySKScene = SKScene(fileNamed: "OverlayScene.sks")
        self.sight = SKSpriteNode(imageNamed: "sight")
        if let sight = self.sight{
            sceneView.overlaySKScene?.addChild(sight)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
     func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        let translation = anchor.transform.translation
        self.presenter?.foundPlane(position: SCNVector3(translation.x, translation.y, translation.z))
    }
    
    // MARK: - GamePresenterDelegate
    func instantiateNode(node: SCNNode) {
        sceneView.scene.rootNode.addChildNode(node)
        
        guard let scene = SCNScene(named: "spider.scn"),
            let node2 = scene.rootNode.childNode(withName: "sphere", recursively: false)
            else { return }
        node2.position = node.position
        sceneView.scene.rootNode.addChildNode(node2)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let position = self.sight?.position {
            let hitList = sceneView.hitTest(position, options: nil)
            
            if let hitObject = hitList.first{
                let node = hitObject.node
                
                if node is SCNText {
                    let textNode = node as! SCNText
                    //Call presenter to check if letter pressed is the right one
                }
            }

        }
        
        
        

    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }
}

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}
