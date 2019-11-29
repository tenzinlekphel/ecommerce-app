//
//  Item.swift
//  Ecommerce-app
//
//  Created by tenzin on 11/29/19.
//  Copyright © 2019 tenzin. All rights reserved.
//

import Foundation
import UIKit

class Item {
    
    var id: String!
    var categoryId: String!
    var name: String!
    var description: String!
    var price: Double!
    var imageLinks: [String]!
    
    
    init() {
        
    }
    
    init(_dictionary: NSDictionary) {
        
        id = _dictionary[kObjectID] as? String
        categoryId = _dictionary[kCATEGORYID] as? String
        name = _dictionary[kName] as? String
        description = _dictionary[kDESCRIPTION] as? String
        price = _dictionary[kPRICE] as? Double
        imageLinks = _dictionary[kImageName] as? [String]
    }
    
}


//Mark: Save item func

func saveItemToFirestore(_ item: Item) {
    FirebaseReference(.Items).document(item.id).setData(itemDictionaryFrom(item) as! [String: Any] )
}


//MARK: Helper Functions

func itemDictionaryFrom(_ item: Item) -> NSDictionary {
    
    return NSDictionary(objects: [item.id, item.categoryId, item.name, item.description, item.price, item.imageLinks], forKeys: [kObjectID as NSCopying, kCATEGORYID as NSCopying, kName as NSCopying, kDESCRIPTION as NSCopying, kPRICE as NSCopying, kIMAGELINKS as NSCopying])
}
