//
//  ShoppingListController.swift
//  Shopping
//
//  Created by Phillip Stene on 11/19/19.
//  Copyright © 2019 Phillip Stene. All rights reserved.
//

import Foundation

class ShoppingListController {
    
    static var shoppingLists = [ShoppingList]()
    
    init() {
        
    }
    
    func addShoppingList(listName: String) {
        let newShoppingList = ShoppingList()
        newShoppingList.name = listName
        ShoppingListController.shoppingLists.append(newShoppingList)
    }
    
    func removeList(index: Int) {
        ShoppingListController.shoppingLists.remove(at: index)
    }
    
    func getListCount() -> Int {
        return ShoppingListController.shoppingLists.count
    }
    
    func getList(index: Int) -> ShoppingList? {
        return ShoppingListController.shoppingLists[index]
    }
}
