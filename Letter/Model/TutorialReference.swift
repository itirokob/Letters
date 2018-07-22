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
         TutorialCellContent(text: "O seu personagem irá aparecer", images: [UIImage(named: "character00")!, UIImage(named: "character00")!, UIImage(named: "character01")!, UIImage(named: "character02")!, UIImage(named: "character03")!, UIImage(named: "character04")!, UIImage(named: "character05")!, UIImage(named: "character05")!]),
         TutorialCellContent(text: "Descubra qual o nome do personagem", images: [UIImage(named: "name00")!, UIImage(named: "name01")!, UIImage(named: "name02")!, UIImage(named: "name03")!, UIImage(named: "name04")!, UIImage(named: "name04")!]),
         TutorialCellContent(text: "Encontre as letras que formam seu nome", images: [UIImage(named: "letter00")!, UIImage(named: "letter01")!, UIImage(named: "letter02")!, UIImage(named: "letter03")!, UIImage(named: "letter04")!, UIImage(named: "letter05")!, UIImage(named: "letter07")!, UIImage(named: "letter08")!, UIImage(named: "letter09")!, UIImage(named: "letter10")!, UIImage(named: "letter11")!, UIImage(named: "letter12")!, UIImage(named: "letter13")!, UIImage(named: "letter14")!, UIImage(named: "letter15")!])]
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
