//
//  ShoppingItemController.swift
//  Shopping
//
//  Created by Phillip Stene on 6/27/19.
//  Copyright © 2019 Phillip Stene. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingItemViewController: SwipeTableViewController {
    var shoppingItems: Results<ShoppingItem>?
    let realm = try! Realm()
    
    var selectedList : ShoppingList? {
        didSet {
            loadShoppingItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = selectedList?.name
        
        tableView.rowHeight = 80.0
    }
    
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = shoppingItems?[indexPath.row] {
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = item.qty
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = shoppingItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Data Model Methods
    func loadShoppingItems() {
        shoppingItems = selectedList?.items.sorted(byKeyPath: "name", ascending: true)
        
        tableView.reloadData()
    }
    
    override func removeFromModel(at indexPath: IndexPath) {
        if let itemForDeletion = shoppingItems?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(itemForDeletion)
                }
            } catch {
                print("Error deleting item, \(error)")
            }
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var nameTextField = UITextField()
        var qtyTextField = UITextField()
        
        
        let alert = UIAlertController(title: "Add Shopping Item", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let currentList = self.selectedList {
                do {
                    try self.realm.write {
                        let newItem = ShoppingItem()
                        newItem.name = nameTextField.text!
                        newItem.qty = qtyTextField.text!
                        currentList.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            
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
