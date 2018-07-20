//
//  ObjectModel.swift
//  Letter
//
//  Created by Bianca Itiroko on 19/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class ObjectModel {
    var id: String
    var filename: String
    var name: String
    var hiddenImage: UIImage
    var image: UIImage
    var sceneName: String {
        return filename + ".scn"
    }
    var nodeName: String {
        return filename
    }
    
    init(id: String, name: String, filename: String, image: UIImage, hiddenImage: UIImage) {
        self.id = id
        self.name = name
        self.filename = filename
        self.image = image
        self.hiddenImage = hiddenImage
    }
}
