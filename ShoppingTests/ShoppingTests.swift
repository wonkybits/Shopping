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
    let slic = ShoppingItemsListController()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        slc.removeAll()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        slc.removeAll()
    }
    
    func testAddList() {
        let list = ShoppingList()
        list.name = "Test List"
        slc.addList(list: list)
        let name = slc.getList(index: 0)?.name
        XCTAssertEqual(name, "Test List")
    }
    
    func testAddItem() {
        let list = ShoppingList()
        list.name = "Test List"
        slc.addList(list: list)
        slic.loadItems(list: slc.getList(index: 0))
        slic.addItem(list: list, name: "Test Item", qty: "1")
        XCTAssertEqual("Test Item", slic.getItem(index: 0)?.name)
    }
    
    func testRemoveItem() {
        let list = ShoppingList()
        list.name = "Test List"
        slc.addList(list: list)
        slic.loadItems(list: slc.getList(index: 0))
        slic.addItem(list: list, name: "Test Item", qty: "1")
        slic.removeItem(at: 0)
        XCTAssertEqual(0, slic.getCount())
    }
    
    func testRemoveList() {
        let list = ShoppingList()
        list.name = "Test List"
        slc.addList(list: list)
        slc.removeList(at: 0)
        XCTAssertEqual(0, slc.getListCount())
    }
    
    func testGetList() {
        let list = ShoppingList()
        list.name = "Test List"
        slc.addList(list: list)
        let pulledList = slc.getList(index: 0)
        XCTAssertEqual(pulledList?.name, "Test List")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
