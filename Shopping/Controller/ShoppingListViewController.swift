//
//  ShoppingListController.swift
//  Shopping
//
//  Created by Phillip Stene on 6/27/19.
//  Copyright © 2019 Phillip Stene. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingListViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var shoppingLists: Results<ShoppingList>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadShoppingLists()
        
        tableView.rowHeight = 80.0
    }
    
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingLists?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let shoppingList = shoppingLists?[indexPath.row] {
            cell.textLabel?.text = shoppingList.name
            
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showShoppingList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ShoppingItemViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedList = shoppingLists?[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    func saveList(list: ShoppingList) {
        do {
            try realm.write {
                realm.add(list)
            }
        } catch {
            print("Error saving shopping list, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadShoppingLists() {
        shoppingLists = realm.objects(ShoppingList.self)
        
        tableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Create Shopping List", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add List", style: .default) { (action) in
            let newShoppingList = ShoppingList()
            newShoppingList.name = textField.text!
            self.saveList(list: newShoppingList)
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
        if let listForDeletion = shoppingLists?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(listForDeletion)
                }
            } catch {
                print("Error deleting shopping list, \(error)")
            }
        }
    }
}
