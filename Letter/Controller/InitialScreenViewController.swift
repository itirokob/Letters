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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load random screen
        let screen: InitialScreen = InitialScreenReference.getRandomScreen()
        if let view = UINib(nibName: screen.nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView {
            self.view.addSubview(view)
            self.view.sendSubview(toBack: view)
        }
        self.button.setImage(UIImage(named: screen.buttonName), for: .normal)
    }
}
