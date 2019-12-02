//
//  AddItemViewController.swift
//  Ecommerce-app
//
//  Created by tenzin on 12/2/19.
//  Copyright © 2019 tenzin. All rights reserved.
//

import UIKit
//import Gallery // Import error
//import JGProgressHUD
//import NVActivityIndicatorView

class AddItemViewController: UIViewController {
    //Mark outlet
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    
    @IBOutlet weak var descption: UITextView!
    
    
    //Mark: Vars
    var category: Category!
    
    var itemImages: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(category.id)
    }
    
    
    //Mark action
    
    @IBAction func doneBarButton(_ sender: Any) {
        dismissKeyboard()
        
        if fieldsAreCompleted() {
            saveToFirebase()
        } else {
            print("Error all fields are required!!")
            //TODO: Show error to the user
            
        }
    }
    

    @IBAction func cameraButtonPress(_ sender: Any) {
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        dismissKeyboard()
         
        
    }
    
    
    //Mark: Helper functions
    
    private func fieldsAreCompleted() -> Bool {
        
        return (name.text != "" && price.text != "" && descption.text != "")
    }
    
    private func dismissKeyboard()
    {
        self.view.endEditing(false)
    }
    
    private func popTheView() {
        self.navigationController?.popViewController(animated: true)
    }
    //Mark: Save item
    private func saveToFirebase() {
        let item = Item()
        item.id = UUID().uuidString
        item.name = name.text!
        item.categoryId = category.id
        item.description = descption.text
        item.price = Double(price.text!)
        
        if itemImages.count > 0 {
            
        } else {
            saveItemToFirestore(item)
            popTheView()
        }
        
    }
}
