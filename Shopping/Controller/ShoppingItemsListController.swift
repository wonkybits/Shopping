//
//  ShoppingItemsListController.swift
//  Shopping
//
//  Created by Phillip Stene on 11/20/19.
//  Copyright © 2019 Phillip Stene. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingItemsListController {
    
    let realm = try! Realm()
    
    var shoppingItems: Results<ShoppingItem>?
    
    init() {
        
    }
    
    func loadItems(list : ShoppingList?) {
        shoppingItems = list?.items.sorted(byKeyPath: "name", ascending: true)
    }
    
    func getCount() -> Int? {
        return shoppingItems?.count
    }
    
    func getItem(index : Int) -> ShoppingItem? {
        return shoppingItems?[index]
    }
    
    func addItem(list : ShoppingList, name : String, qty : String) {
        do {
            try self.realm.write {
                let newItem = ShoppingItem()
                newItem.name = name
                newItem.qty = qty
                list.items.append(newItem)
            }
        } catch {
            print("Error saving new items, \(error)")
        }
    }
    
    func removeItem(at index : Int) {
        if let itemForDeletion = shoppingItems?[index] {
            do {
                try realm.write {
                    realm.delete(itemForDeletion)
                }
            } catch {
                print("Error deleting item, \(error)")
            }
        }
    }
    
    func toggleDone(index : Int) {
        if let item = shoppingItems?[index] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
    }
}
