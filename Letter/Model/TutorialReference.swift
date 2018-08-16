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
        [TutorialCellContent(text: NSLocalizedString("TUT_FIND", comment: ""), images:
            [UIImage(named: "paw01")!, UIImage(named: "paw02")!, UIImage(named: "paw03")!, UIImage(named: "paw04")!, UIImage(named: "paw05")!, UIImage(named: "paw07")!, UIImage(named: "paw08")!, UIImage(named: "paw09")!, UIImage(named: "paw10")!, UIImage(named: "paw11")!, UIImage(named: "paw12")!, UIImage(named: "paw13")!, UIImage(named: "paw14")!, UIImage(named: "paw15")!]),
         TutorialCellContent(text: NSLocalizedString("TUT_TAP", comment: ""), images: [#imageLiteral(resourceName: "tappaw01"), #imageLiteral(resourceName: "tappaw02")]),
         TutorialCellContent(text: NSLocalizedString("TUT_SHOW", comment: ""), images: [UIImage(named: "character00")!, UIImage(named: "character00")!, UIImage(named: "character01")!, UIImage(named: "character02")!, UIImage(named: "character03")!, UIImage(named: "character04")!, UIImage(named: "character05")!, UIImage(named: "character05")!]),
         TutorialCellContent(text: NSLocalizedString("TUT_NAME", comment: ""), images: [UIImage(named: "name00")!, UIImage(named: "name01")!, UIImage(named: "name02")!, UIImage(named: "name03")!, UIImage(named: "name04")!, UIImage(named: "name04")!]),
         TutorialCellContent(text: NSLocalizedString("TUT_LETTER", comment: ""), images: [UIImage(named: "letter00")!, UIImage(named: "letter01")!, UIImage(named: "letter02")!, UIImage(named: "letter03")!, UIImage(named: "letter04")!, UIImage(named: "letter05")!, UIImage(named: "letter07")!, UIImage(named: "letter08")!, UIImage(named: "letter09")!, UIImage(named: "letter10")!, UIImage(named: "letter11")!, UIImage(named: "letter12")!, UIImage(named: "letter13")!, UIImage(named: "letter14")!, UIImage(named: "letter15")!])]
    
    let pawTutorial: [UIImage] = [UIImage(named: "paw01")!, UIImage(named: "paw02")!, UIImage(named: "paw03")!, UIImage(named: "paw04")!, UIImage(named: "paw05")!, UIImage(named: "paw07")!, UIImage(named: "paw08")!, UIImage(named: "wpaw09")!, UIImage(named: "wpaw10")!, UIImage(named: "wpaw11")!, UIImage(named: "wpaw12")!, UIImage(named: "wpaw13")!, UIImage(named: "wpaw14")!, UIImage(named: "wpaw15")!]
    var reversedPaws: [UIImage] {
        var array: [UIImage] = []
        for index in (0..<self.pawTutorial.count).reversed() {
            array.append(self.pawTutorial[index])
        }
        return array
    }
    var pawAnimation: [UIImage] {
        return pawTutorial + reversedPaws
    }
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
