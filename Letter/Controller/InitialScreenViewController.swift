//
//  InitialScreenViewController.swift
//  Letter
//
//  Created by Giovani Nascimento Pereira on 19/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class InitialScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let view = UINib(nibName: "savana", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView {
            self.view.addSubview(view)
            self.view.sendSubview(toBack: view)
        }
    }
}
