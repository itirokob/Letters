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

// Action to self-destruct nodes after 0.5s
let selfDestructAction: SCNAction = SCNAction.sequence([SCNAction.wait(duration: 0.5), SCNAction.run({ (node) in
    node.removeFromParentNode()
})])
let letterRepositionVector: SCNVector3 = SCNVector3(0.2, 0.5, -0.1)

class ViewController: UIViewController, ARSCNViewDelegate, GamePresenterDelegate {
    @IBOutlet var sceneView: ARSCNView!
    var objectModel:ObjectModel?
    var presenter:GamePresenter?
    var sight: SKSpriteNode?
    var lettersNode:SCNNode?
    var correctLettersArray:[CorrectLetter] = []

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var fxView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/empty.scn")!
        
        // Set the scene to the view and the delegate
        sceneView.scene = scene
        sceneView.delegate = self
        
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
        
        // Hide stack view until presented on the game
        self.stackView.isHidden = true
        self.fxView.isHidden = true
        
        AudioManager.instance.lowVolume()
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
    
    /// Go Back to the Menu
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Show the Tutorial
    @IBAction func helpButton(_ sender: Any) {
        self.performSegue(withIdentifier: "showTutorialSegue", sender: self)
    }
    
    /// Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "endGameSegue" {
            if let viewController = segue.destination as? EndGameViewController {
                viewController.object = self.objectModel
            }
        }
    }
    
    /// Iterate through the nodes and set the text in each one
    ///
    /// - Parameters:
    ///   - lettersNode: all nodes that we need to set text
    ///   - wordArray: word to be written in nodes
    fileprivate func setNodesText(_ lettersNode: SCNNode, _ wordArray: inout [Character]) {
        for node in lettersNode.childNodes{
            if wordArray.isEmpty == false {
                if let nodeText = node.geometry as? SCNText {
                    nodeText.string = String(wordArray.first!)
                    wordArray.remove(at: 0)
                }
            }
        }
    }
    
    /// Set the letter nodes text
    func feedLetters(){
        DispatchQueue.main.async {
            self.stackView.isHidden = false
            self.fxView.isHidden = false
        }
        if let lettersNode = self.lettersNode, let object = self.objectModel{
            var wordArray = Array(object.name.uppercased())
            self.setNodesText(lettersNode, &wordArray)
        } else {
            print("Error in feedLetters")
        }
    }
    
    /// Load the correct letters panel in the screen
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
    
    /// When we have already put the 3D object, we don't need to detect planes anymore
    func stopPlaneDetection(){
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .init(rawValue: 0)
        self.sceneView.session.run(configuration)
        self.sceneView.debugOptions = []
    }

    // MARK: - ARSCNViewDelegate
     func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        let translation = anchor.transform.translation
        self.presenter?.foundPlane(position: SCNVector3(translation.x, translation.y, translation.z))
        self.stopPlaneDetection()
    }
    
    // MARK: - GamePresenterDelegate
    
    /// If a plane is detected, we'll instantiate the object and the letters
    ///
    /// - Parameters:
    ///   - node: object node to be instantiated
    ///   - lettersNode: letter's node to be instatiated
    func instantiateNode(node: SCNNode, lettersNode: SCNNode) {
        sceneView.scene.rootNode.addChildNode(node)
        sceneView.scene.rootNode.addChildNode(lettersNode)
        self.lettersNode = lettersNode
        
        self.feedLetters()
    }

    /// When user hits the correct letter,
    /// we'll update the display of letters in the screen
    ///
    /// - Parameters:
    ///   - letter: letter pressed correctly
    ///   - index: index of the letter in the correct word
    ///   - nodePressed: node pressed (so we can remove it)
    func updateCorrectLetters(letter: String, index:Int, nodePressed: SCNNode) {
        self.correctLettersArray[index].letter.text = letter
        nodePressed.removeFromParentNode()
        // TODO: Restart the confetti's
//        addConfetti(at: nodePressed.position)
    }

    /// When a wrong letter is pressed, we'll send a feedback to the user
    func wrongLetterPressed() {
    }
    
    /// Run a SCNParticle animation on the given position
    ///
    /// - Parameter position: the position to run the animation
    func addConfetti(at position: SCNVector3) {
        let reposition = position + letterRepositionVector
        guard let confettiParticles = SCNParticleSystem(named: "Confetti.scnp", inDirectory: nil) else { return }
        let node = SCNNode()
        node.addParticleSystem(confettiParticles)
        node.position = reposition
        sceneView.scene.rootNode.addChildNode(node)
        node.runAction(selfDestructAction)
    }
    
    /// This func gets the letter from node pressed and check if it's correct
    ///
    /// - Parameter position: position where the user pressed
    fileprivate func checkLetterPressed(_ position: CGPoint) {
        let hitList = sceneView.hitTest(position, options: nil)
        
        //The SCNText is the geometry parameter from node
        if let node = hitList.first?.node.parent {
            if let nodeText = node.geometry as? SCNText, let letter = nodeText.string as? String {
                self.presenter?.letterPressed(letter: letter, nodePressed: node)
            }
        }
    }
    
    /// Finish the Game
    func endGame() {
        self.performSegue(withIdentifier: "endGameSegue", sender: self)
    }
    
    /// This func recognizes user's touches, when it happens we'll check if the pressed letter is correct
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: sceneView)
            self.checkLetterPressed(position)
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
