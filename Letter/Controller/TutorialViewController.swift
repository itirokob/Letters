//
//  TutorialViewController.swift
//  Letter
//
//  Created by Giovani Nascimento Pereira on 22/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var cells: [TutorialCellContent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cells = TutorialReference().cells
        self.collectionView.layer.cornerRadius = 20
        pageControl.numberOfPages = self.cells.count
        
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension TutorialViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tutorialCell", for: indexPath) as? TutorialCollectionViewCell else { return UICollectionViewCell()}
        
        cell.images = self.cells[indexPath.row].animationImages
        cell.label.text = self.cells[indexPath.row].text
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
    }
    
}
