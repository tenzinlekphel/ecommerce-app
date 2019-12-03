//
//  Downloader.swift
//  Ecommerce-app
//
//  Created by tenzin on 12/3/19.
//  Copyright © 2019 tenzin. All rights reserved.
//

import Foundation
import FirebaseStorage

let storage = Storage.storage()

func uploadImages(images: [UIImage?], itemId: String, completion: @escaping (_ imageLinks: [String]) -> Void){
    
    if Reachabilty.HasConnection() {
        var uploadedImagesCount = 0
        var imageLinkArray: [String] = []
        var nameSuffix = 0
        
        for image in images {
            
            let fileName = "ItemImages/" + itemId + "/" + "\(nameSuffix)" + ".jpg"
            let imageData = image!.jpegData(compressionQuality: 0.5)
        }
        
    } else {
        print("No Internet Connection")
    }
}



func saveImageInFirebase(imageData: Data, fileName: String, completion: @escaping (_ imageLink: String?) -> Void) {
    
    var task: StorageUploadTask!
    
    let storageRef = storage.reference(forURL: kFILEREREFERNCE).child(fileName)
    
    task = storageRef.putData(imageData, metadata: nil, completion: { (
        metadata, error) in
        
        task.removeAllObservers()
        
        if error != nil {
            print("Error uploading image", error!.localizedDescription)
            completion(nil)
            return 
        }
    })
    
}
