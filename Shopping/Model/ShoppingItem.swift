//
//  ShoppingItem.swift
//  Shopping
//
//  Created by Phillip Stene on 6/27/19.
//  Copyright © 2019 Phillip Stene. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingItem: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var qty: String = ""
    @objc dynamic var done: Bool = false
    var parentList = LinkingObjects(fromType: ShoppingList.self, property: "items")
}
