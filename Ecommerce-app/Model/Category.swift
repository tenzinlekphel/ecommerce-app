//
//  Category.swift
//  Ecommerce-app
//
//  Created by tenzin on 11/28/19.
//  Copyright © 2019 tenzin. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Category {
    
    var id: String
    var name: String
    var image: UIImage?
    var imageName: String?
    
    
    init(_name: String, _imageName: String) {
        id = ""
        name = _name
        imageName = _imageName
        image = UIImage(named: _imageName)
    }
    
    init(_dictionary: NSDictionary) {
        id = _dictionary[kObjectID] as! String
        name = _dictionary[kName] as! String
        image = UIImage(named: _dictionary[kImageName] as! String)
    }
}
    

//Mark: Download category from firebase
func downloadCategoryfromFirebase(completion: @escaping (_ categoryArray: [Category])-> Void) {
    var categoryArray: [Category] = []
    
    FirebaseReference(.Category).getDocuments{ (snapshot, error) in
        
        guard let snapshot = snapshot else {
            completion(categoryArray)
            return
        }
        
        if !snapshot.isEmpty {
            for categoryDict in snapshot.documents {
                categoryArray.append(Category(_dictionary: categoryDict.data() as NSDictionary))
            }
        }
        
        completion(categoryArray)
    }
}


    
    //Mark: Save category functions
    func saveCategoryToFirebase(category: Category) {
        let id = UUID().uuidString
        category.id = id
        FirebaseReference(.Category).document(id).setData(categoryDictionaryFrom(category) as! [String : Any])
    }
    
    
    //Mark: Helpers
    func categoryDictionaryFrom(_ category: Category) -> NSDictionary {
        return NSDictionary(objects: [category.id, category.name, category.imageName], forKeys: [kObjectID as NSCopying, kName as NSCopying, kImageName as NSCopying])
    }

//use only one time
//   func createCategorySet() {
//       let womenClothing = Category(_name: "Women's Clothing & Tools", _imageName: "womenCloth")
//       let footWear = Category(_name: "Footwear", _imageName: "footWar")
//       let electronics = Category(_name: "Electronics", _imageName: "electronics")
//       let menClothing = Category(_name: "Men's Clothing & Tools", _imageName: "Mens cloth")
//       let health = Category(_name: "Health & Beauty", _imageName: "health products")
//       let baby = Category(_name: "Baby stuff", _imageName: "baby products")
//       let jewelery = Category(_name: "Diamonds and Gold", _imageName: "Diamonds rings")
//       let industry = Category(_name: "Industry & tools", _imageName: "industry weapons")
//
//       let pet = Category(_name: "animals", _imageName: "animals")
//
//       let arrayOfCategories = [womenClothing,menClothing,footWear,baby,health,jewelery,electronics,industry,pet]
//
//       for category in arrayOfCategories {
//           saveCategoryToFirebase(category: category)
//       }
//
//   }
