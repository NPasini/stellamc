//
//  DepartmentViewControllerNetworkNotAvailableTests.swift
//  stellamcUITests
//
//  Created by Nicolò Pasini on 27/03/21.
//

import XCTest

class DepartmentViewControllerNetworkNotAvailableTests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()

        app.launchArguments = ["-UITesting", "true", "-networkNotAvailable", "true"]
        app.launchEnvironment = ["testPage": "department"]

        app.launch()
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAppearance() throws {
        XCTAssert(app.navigationBars["Products"].exists)

        let tableView = app.tables["productsTableView"]
        XCTAssertTrue(tableView.exists)
        XCTAssertEqual(tableView.cells.count, 0)
    }
}


