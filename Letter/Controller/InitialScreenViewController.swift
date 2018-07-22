//
//  InitialScreenViewController.swift
//  Letter
//
//  Created by Giovani Nascimento Pereira on 19/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class InitialScreenViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    var customView: UIView?
    
    @IBOutlet weak var sfxButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Check music states
        updateMusicButton()
        updateSFXButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCustomView()
    }
    
    func updateMusicButton() {
        if UserDefaultsManager.instance.getMusicState() {
            self.musicButton.setImage(#imageLiteral(resourceName: "music"), for: .normal)
            AudioManager.instance.playGameMusic(for: .soundtrack)
        } else {
            self.musicButton.setImage(#imageLiteral(resourceName: "noMusic"), for: .normal)
            AudioManager.instance.stopMusic()
        }
    }
    
    func updateSFXButton() {
        if UserDefaultsManager.instance.getSFXState() {
            self.sfxButton.setImage(#imageLiteral(resourceName: "sfx"), for: .normal)
        } else {
            self.sfxButton.setImage(#imageLiteral(resourceName: "noSFX"), for: .normal)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        customView?.removeFromSuperview()
    }
    
    private func loadCustomView() {
        // Load random screen
        let screen: InitialScreen = InitialScreenReference.getRandomScreen()
        if let view = UINib(nibName: screen.nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView {
            self.view.addSubview(view)
            self.view.sendSubview(toBack: view)
            customView = view
        }
        self.button.setImage(UIImage(named: screen.buttonName), for: .normal)
    }
    
    @IBAction func sfxButtonAction(_ sender: UIButton) {
        UserDefaultsManager.instance.setSFXState(to: !(UserDefaultsManager.instance.getSFXState()))
        self.updateSFXButton()
    }
    
    @IBAction func musicButtonAction(_ sender: UIButton) {
        UserDefaultsManager.instance.setMusicState(to: !(UserDefaultsManager.instance.getMusicState()))
        self.updateMusicButton()
    }
}
