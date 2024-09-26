//
//  RecipesUITests.swift
//  RecipesUITests
//
//  Created by Miha on 24/09/2024.
//

import XCTest

class RecipesUITests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testIfSearchButtonExists() throws {
        let searchButton = app.buttons["SearchButton"]
        XCTAssertTrue(searchButton.exists)
    }
    
    func testIfSearchInputExists() throws {
        let searchIput = app.textFields["SearchInput"]
        XCTAssertTrue(searchIput.exists)
    }
    
    func testIfListHiddenAtStart() throws {
        let list = app.tables["RecipesList"]
        XCTAssertFalse(list.exists)
    }
    
    func testIfListShows() throws {
        let searchIput = app.textFields["SearchInput"]
        searchIput.tap()
        searchIput.typeText("Chicken")
        let searchButton = app.buttons["SearchButton"]
        searchButton.tap()
        sleep(10)
        let list = app.tables
        let count = list.cells.count
        XCTAssert(count > 0)
    }
}
