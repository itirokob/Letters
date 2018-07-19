//
//  ObjectModel.swift
//  Letter
//
//  Created by Bianca Itiroko on 19/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class ObjectModel {
    var name: String
    var hiddenImage: UIImage
    var image: UIImage
    var sceneName: String {
        return name + ".scn"
    }
    var nodeName: String {
        return name
    }
    
    init(name: String, image: UIImage, hiddenImage: UIImage) {
        self.name = name
        self.image = image
        self.hiddenImage = hiddenImage
    }
}
