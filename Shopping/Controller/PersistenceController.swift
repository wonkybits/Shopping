//
//  PersistenceController.swift
//  Shopping
//
//  Created by Phillip Stene on 11/20/19.
//  Copyright © 2019 Phillip Stene. All rights reserved.
//

import Foundation
import RealmSwift

class PersistenceController {
    
    let realm : Realm
    
    init() {
        realm = try! Realm()
    }
    
    func saveData() {
        for list in ShoppingListController.shoppingLists {
            do {
                try realm.write {
                    realm.add(list)
                }
            } catch {
                print("Error saving shopping list, \(error)")
            }
        }
    }
    
    func loadData() {
        let shoppingLists = realm.objects(ShoppingList.self)
        
        ShoppingListController.shoppingLists.removeAll()
        
        for list in shoppingLists {
            ShoppingListController.shoppingLists.append(list)
        }
    }
}
