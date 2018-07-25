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
    var textureName: String
    var textureImage: UIImage {
        if let image = UIImage(named: self.textureName) {
            return image
        }
        return UIImage(named: "extraTexture")!
    }
    var sceneName: String {
        return filename + ".scn"
    }
    var nodeName: String {
        return filename
    }
    
    init(id: String, name: String, filename: String, image: UIImage, hiddenImage: UIImage, textureName: String) {
        self.id = id
        self.name = name
        self.filename = filename
        self.image = image
        self.hiddenImage = hiddenImage
        self.textureName = textureName
    }
}
