//
//  ShoppingListController.swift
//  Shopping
//
//  Created by Phillip Stene on 6/27/19.
//  Copyright © 2019 Phillip Stene. All rights reserved.
//

import Foundation
import UIKit

class ShoppingListViewController: SwipeTableViewController {
    
    let slc = ShoppingListController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80.0
    }
    
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingListController.shoppingLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        let shoppingList = ShoppingListController.shoppingLists[indexPath.row]
        cell.textLabel?.text = shoppingList.name
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showShoppingList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ShoppingItemViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedList = ShoppingListController.shoppingLists[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Create Shopping List", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add List", style: .default) { (action) in
            self.slc.addShoppingList(listName: textField.text!)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Please specify a name for the list"
            textField = alertTextField
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func removeFromModel(at indexPath: IndexPath) {
        slc.removeList(index: indexPath.row)
    }
}
