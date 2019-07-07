//
//  ShoppingList.swift
//  Shopping
//
//  Created by Phillip Stene on 6/27/19.
//  Copyright © 2019 Phillip Stene. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingList: Object {
    @objc dynamic var name: String = ""
    let items = List<ShoppingItem>()
}
