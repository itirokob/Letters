//
//  TutorialReference.swift
//  Letter
//
//  Created by Giovani Nascimento Pereira on 22/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class TutorialReference {
    
    let cells: [TutorialCellContent] =
        [TutorialCellContent(text: "Encontre um lugar bem plano", images:
            [UIImage(named: "plane00")!, UIImage(named: "plane01")!, UIImage(named: "plane02")!, UIImage(named: "plane03")!, UIImage(named: "plane04")!, UIImage(named: "plane05")!, UIImage(named: "plane07")!, UIImage(named: "plane08")!, UIImage(named: "plane09")!, UIImage(named: "plane10")!, UIImage(named: "plane11")!, UIImage(named: "plane12")!, UIImage(named: "plane13")!, UIImage(named: "plane14")!, UIImage(named: "plane15")!]),
         TutorialCellContent(text: "O seu personagem irá aparecer", images: []),
         TutorialCellContent(text: "Descubra qual o nome do personagem", images: []),
         TutorialCellContent(text: "Encontre as letras que formam seu nome", images: [])]
}

struct TutorialCellContent {
    var text: String
    var images: [UIImage]
    var reversedImages: [UIImage] {
        var array: [UIImage] = []
        for index in (0..<self.images.count).reversed() {
            array.append(self.images[index])
        }
        return array
    }
    var animationImages: [UIImage] {
        return self.images + self.reversedImages
    }
    
    init(text: String, images: [UIImage]) {
        self.text = text
        self.images = images
    }
}
