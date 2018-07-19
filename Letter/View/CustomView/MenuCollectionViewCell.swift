//
//  MenuCollectionViewCell.swift
//  Letter
//
//  Created by Giovani Nascimento Pereira on 19/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.background.layer.cornerRadius = 10
        self.background.clipsToBounds = true
    }
}
