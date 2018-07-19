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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.objects.append(contentsOf: ObjectReference.instance.objects)
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
        
        if let cell = cell as? MenuCollectionViewCell {
            cell.label.text = objects[indexPath.row].name
            cell.image.image = objects[indexPath.row].image
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "goToGameSegue", sender: self)
    }
    
}
