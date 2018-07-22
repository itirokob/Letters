//
//  TutorialCollectionViewCell.swift
//  Letter
//
//  Created by Giovani Nascimento Pereira on 22/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class TutorialCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var images: [UIImage] = [] {
        didSet {
            self.imageView.animationImages = images
            self.imageView.animationRepeatCount = 0
            self.imageView.animationDuration = 2.0
            self.imageView.startAnimating()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
    }
}
