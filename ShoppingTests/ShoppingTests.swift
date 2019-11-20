//
//  ShoppingTests.swift
//  ShoppingTests
//
//  Created by Phillip Stene on 11/19/19.
//  Copyright © 2019 Phillip Stene. All rights reserved.
//

import XCTest

@testable import Shopping

class ShoppingTests: XCTestCase {
    
    let slc = ShoppingListController()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        ShoppingListController.shoppingLists.removeAll()
    }

    func testAddList() {
        let initListCount = ShoppingListController.shoppingLists.count
        slc.addShoppingList(listName: "Test List")
        XCTAssertTrue(initListCount < ShoppingListController.shoppingLists.count)
    }
    
    func testRemoveList() {
        slc.addShoppingList(listName: "Test List")
        let count = ShoppingListController.shoppingLists.count
        XCTAssertTrue(count > 0)
    }
    
    func testGetList() {
        let count = slc.getListCount() - 1
        slc.addShoppingList(listName: "Test List")
        let list = slc.getList(index: count + 1)
        print(list.name)
        XCTAssertTrue(list.name == "Test List")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
