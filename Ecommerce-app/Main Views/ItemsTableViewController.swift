//
//  ItemsTableViewController.swift
//  Ecommerce-app
//
//  Created by tenzin on 11/28/19.
//  Copyright © 2019 tenzin. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    
    //Marks vars
    var category: Category?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("we have selected", category?.name)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
    //Mark Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemToAddItemSeg" {
            
            let vc = segue.destination as! AddItemViewController
            vc.category = category!
            
        }
        
    }
}
