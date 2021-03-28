//
//  DepartmentViewControllerTests.swift
//  stellamcUITests
//
//  Created by Nicolò Pasini on 27/03/21.
//

import XCTest

class DepartmentViewControllerTests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()

        app.launchArguments = ["-UITesting", "true"]
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
        XCTAssertEqual(tableView.cells.count, 30)

        let messageView = app.otherElements["messageView"]
        XCTAssertFalse(messageView.exists)

        let messageLabel = app.staticTexts["messageLabel"]
        XCTAssertFalse(messageLabel.exists)

        for index in 0..<tableView.cells.count {
            let cell = app.cells["DataCell\(index)"].firstMatch
            let text = cell.staticTexts.element(matching:.any, identifier: "productName")
            XCTAssertEqual(text.label, "Name \(index + 1)")
        }
    }

    func testLoadNewData() throws {
        XCTAssert(app.navigationBars["Products"].exists)

        let tableView = app.tables["productsTableView"]

        tableView.swipeUp()

        while !app.cells["DataCell24"].firstMatch.isHittable {
            tableView.swipeUp()
        }

        XCTAssertEqual(tableView.cells.count, 30)

        for index in 0..<tableView.cells.count {
            let cell = app.cells["DataCell\(index)"].firstMatch
            let text = cell.staticTexts.element(matching:.any, identifier: "productName")
            XCTAssertEqual(text.label, "Name \(index + 1)")
        }
    }
}


