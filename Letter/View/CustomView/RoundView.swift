//
//  RoundView.swift
//  Letter
//
//  Created by Giovani Nascimento Pereira on 19/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

@IBDesignable class RoundView: UIView {
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }
}
