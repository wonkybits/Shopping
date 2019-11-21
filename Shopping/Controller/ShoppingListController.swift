//
//  ShoppingListController.swift
//  Shopping
//
//  Created by Phillip Stene on 11/20/19.
//  Copyright © 2019 Phillip Stene. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingListController {
    
    let realm = try! Realm()
    
    var shoppingLists: Results<ShoppingList>?
    
    init() {
        shoppingLists = realm.objects(ShoppingList.self)
    }
    
    func getListCount() -> Int? {
        return shoppingLists?.count
    }
    
    func getList(index : Int) -> ShoppingList? {
        return shoppingLists?[index]
    }
    
    func addList(list : ShoppingList) {
        do {
            try realm.write {
                realm.add(list)
            }
        } catch {
            print("Error saving shopping list, \(error)")
        }
    }
    
    func removeList(at index : Int) {
        if let listForDeletion = getList(index: index) {
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
