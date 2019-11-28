//
//  CategoryCollectionViewCell.swift
//  Ecommerce-app
//
//  Created by tenzin on 11/27/19.
//  Copyright © 2019 tenzin. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    func generateCell(_ category: Category) {
        nameLabel.text = category.name
        imageView.image = category.image
    }

}
