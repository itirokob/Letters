//
//  MenuViewController.swift
//  Letter
//
//  Created by Giovani Nascimento Pereira on 19/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var objects: [ObjectModel] = []
    var selectedIndex: Int = 0
    var objectDictionary: [String: Bool] = [:]

    @IBOutlet weak var closeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.objectDictionary = UserDefaultsManager.instance.getObjectsDictionary()
        self.objects.append(contentsOf: ObjectReference.instance.objects)
        closeView.layer.cornerRadius = closeView.frame.size.width / 2
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGameSegue" {
            guard let controller = segue.destination as? ViewController else { return }
            controller.objectModel = objects[selectedIndex]
        }
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath)
        let row = indexPath.row
        
        if let cell = cell as? MenuCollectionViewCell {
            let state = objectDictionary[objects[row].id] ?? false
            if state {
                cell.label.text = objects[row].name.capitalized
                cell.image.image = objects[row].image
            } else {
                cell.label.text = ""
                cell.image.image = objects[row].hiddenImage
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "goToGameSegue", sender: self)
    }
    
}
