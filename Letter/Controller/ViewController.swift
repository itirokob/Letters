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
    var lettersNode:SCNNode?
    var correctLettersArray:[CorrectLetter] = []

    @IBOutlet weak var stackView: UIStackView!

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
        
        //Load underlines for correct letters
        self.loadCorrectLetters()
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
    
    func feedLetters(){
        if let lettersNode = self.lettersNode, let object = self.objectModel{
            var wordArray = Array(object.name.uppercased())

            for node in lettersNode.childNodes{
                if wordArray.isEmpty == false {
                    if let nodeText = node.geometry as? SCNText {
                        nodeText.string = String(wordArray.first!)
                        wordArray.remove(at: 0)
                    }
                }
            }
        } else {
            print("Error in feedLetters")
        }
    }
    
    func loadCorrectLetters(){
        guard let object = self.objectModel else { return }
        
        for _ in 0..<object.name.count{
            if let view = UINib(nibName: "CorrectLetter", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? CorrectLetter {
                view.letter.text = " "
                self.stackView.addArrangedSubview(view)
                self.correctLettersArray.append(view)
            }
        }
    }

    // MARK: - ARSCNViewDelegate
     func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        let translation = anchor.transform.translation
        self.presenter?.foundPlane(position: SCNVector3(translation.x, translation.y, translation.z))
    }
    
    // MARK: - GamePresenterDelegate
    func instantiateNode(node: SCNNode, lettersNode: SCNNode) {
        sceneView.scene.rootNode.addChildNode(node)
        sceneView.scene.rootNode.addChildNode(lettersNode)
        self.lettersNode = lettersNode
        
        self.feedLetters()
    }
    
    func updateCorrectLetters(letter: String, index:Int) {
        self.correctLettersArray[index].letter.text = letter
        //Updates the correct letters
    }

    func wrongLetterPressed() {
        //Sends a feedback for the user
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: sceneView)
            let hitList = sceneView.hitTest(position, options: nil)
            
            //The SCNText is the geometry parameter from node
            if let node = hitList.first?.node.parent {
                if let nodeText = node.geometry as? SCNText, let letter = nodeText.string as? String {
                    self.presenter?.letterPressed(letter: letter)
                }
            }
            
//            if hitList.count > 1{
//                let node = hitList[1].node
//                if let nodeText = node.geometry as? SCNText, let letter = nodeText.string as? String {
//                    self.presenter?.letterPressed(letter: letter)
//                }
//            }
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
