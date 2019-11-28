//
//  CategoryCollectionViewController.swift
//  Ecommerce-app
//
//  Created by tenzin on 11/27/19.
//  Copyright © 2019 tenzin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoryCollectionViewController: UICollectionViewController {

    //Mark: Vars
    var categoryArray: [Category] = []
    
    private let sectionInset = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    private let itemsPerRow: CGFloat = 3
    //Mark: View lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadCategories()
    }


    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categoryArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCollectionViewCell
        cell.generateCell(categoryArray[indexPath.row])
        return cell
    }

    //Mark: UICollectionView Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CategoryToItemSeg", sender: categoryArray[indexPath.row])
    }
    
    // Mark: Download categories
    private func loadCategories() {
        downloadCategoryfromFirebase{ (allCategoris) in
            self.categoryArray = allCategoris
            self.collectionView.reloadData()
    }
}
    
    
    //Mark: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CategoryToItemSeg" {
            let vc = segue.destination as! ItemsTableViewController
            vc.category = sender as! Category
        }
    }

}


extension CategoryCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInset.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let withPerItem = availableWidth / itemsPerRow
        return CGSize(width: withPerItem, height: withPerItem)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInset.left
    }
    
}
