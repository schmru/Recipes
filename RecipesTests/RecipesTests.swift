//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Miha on 24/09/2024.
//

import XCTest
@testable import Recipes

class RecipesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataFetching() throws {
        NetworkManager.shared.fetchData(searchText: "chicken") { result in
            switch result {
            case .success(let hits):
                XCTAssertTrue(hits.count > 0)
            case .failure(_):
                XCTFail("Data fetching unsuccessful with errror")
            }
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
