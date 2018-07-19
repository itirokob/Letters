//
//  IndiaScreen.swift
//  Letter
//
//  Created by Giovani Nascimento Pereira on 19/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class IndiaScreen: UIView {

    @IBOutlet weak var cloud01: UIImageView!
    @IBOutlet weak var cloud02: UIImageView!
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        UIView.animate(withDuration: 60) {
            let position01 = self.cloud01.layer.position
            self.cloud01.layer.position = CGPoint(x: -100, y: position01.y)
            let position02 = self.cloud02.layer.position
            self.cloud02.layer.position = CGPoint(x: 500, y: position02.y)
        }
    }
}
