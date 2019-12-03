//
//  AddItemViewController.swift
//  Ecommerce-app
//
//  Created by tenzin on 12/2/19.
//  Copyright © 2019 tenzin. All rights reserved.
//

import UIKit
import Gallery
import JGProgressHUD
import NVActivityIndicatorView

class AddItemViewController: UIViewController {
    //Mark outlet
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var descption: UITextView!
    
    
    //Mark: Vars
    var category: Category!
    var gallery: GalleryController!
    let hud = JGProgressHUD(style: .dark)
    
    
    var activityIndicator: NVActivityIndicatorView?
    
    var itemImages: [UIImage?] = []
    
    
    //Mark: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        activityIndicator = NVActivityIndicatorView(
            frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 30, width: 60, height: 60), type: .ballPulse, color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), padding: nil
        )
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
        itemImages = []
        showImageGallery()
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
        showLoadingIndicator()
        let item = Item()
        item.id = UUID().uuidString
        item.name = name.text!
        item.categoryId = category.id
        item.description = descption.text
        item.price = Double(price.text!)
        
        if itemImages.count > 0 {
            
            uploadImages(images: itemImages, itemId: item.id) {
                (imageLikArray) in
                
                item.imageLinks = imageLikArray
                
                saveItemToFirestore(item)
                self.popTheView()
            }
            
        } else {
            saveItemToFirestore(item)
            popTheView()
        }
    }
    
    
    //Mark: Activity
    private func showLoadingIndicator() {
        
        if activityIndicator != nil {
            self.view.addSubview(activityIndicator!)
            activityIndicator!.stopAnimating()
        }
    }
    
    private func hideLoadingIndicator() {
        if activityIndicator != nil {
            activityIndicator!.removeFromSuperview()
            activityIndicator!.stopAnimating()
        }
        
    }
    
    //Mark: Show Gallery
    private func showImageGallery() {
        self.gallery = GalleryController()
        self.gallery.delegate = self
        
        Config.tabsToShow = [.imageTab, .cameraTab]
        Config.Camera.imageLimit = 6
        
        self.present(self.gallery, animated: true, completion: nil)
    }
}



extension AddItemViewController: GalleryControllerDelegate {
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        if images.count > 0 {
            Image.resolve(images: images) { (resolvedImages) in
                self.itemImages = resolvedImages
            }
        }
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
