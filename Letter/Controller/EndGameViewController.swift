//
//  EndGameViewController.swift
//  Letter
//
//  Created by Giovani Nascimento Pereira on 20/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {

    // Outlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // Variables
    var object: ObjectModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backView.layer.cornerRadius = 10
        
        guard let object = self.object else { return }
        self.label.text = object.name.uppercased()
        self.imageView.image = object.image
        
        UserDefaultsManager.instance.updateObjectsDictionary(with: [object.id: true])
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backToMenuSegue", sender: self)
    }
}
