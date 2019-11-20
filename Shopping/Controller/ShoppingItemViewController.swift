//
//  ShoppingItemController.swift
//  Shopping
//
//  Created by Phillip Stene on 6/27/19.
//  Copyright © 2019 Phillip Stene. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class ShoppingItemViewController: SwipeTableViewController {
    
    var selectedList = ShoppingList()
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = selectedList.name
        
        tableView.rowHeight = 80.0
    }
    
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedList.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = selectedList.items[indexPath.row].name
        cell.detailTextLabel?.text = selectedList.items[indexPath.row].qty
        cell.accessoryType = selectedList.items[indexPath.row].done ? .checkmark : .none
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = selectedList.items[indexPath.row]
        do {
            try realm.write {
                item.done = !item.done
            }
        } catch {
            print("Error saving done status, \(error)")
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Data Model Methods
    
    override func removeFromModel(at indexPath: IndexPath) {
        selectedList.items.remove(at: indexPath.row)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var nameTextField = UITextField()
        var qtyTextField = UITextField()
        
        
        let alert = UIAlertController(title: "Add Shopping Item", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = ShoppingItem()
            newItem.name = nameTextField.text!
            newItem.qty = qtyTextField.text!
            self.selectedList.items.append(newItem)
            
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            nameTextField = alertTextField
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Quantity"
            qtyTextField = alertTextField
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}
