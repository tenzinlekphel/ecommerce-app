//
//  FirebaseCollectionReference.swift
//  Ecommerce-app
//
//  Created by tenzin on 11/27/19.
//  Copyright © 2019 tenzin. All rights reserved.
//

import Foundation
import FirebaseFirestore


enum FCollectionReference: String {
    case User
    case Category
    case Items
    case Basket
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}



