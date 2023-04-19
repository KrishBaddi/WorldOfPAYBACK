//
//  WorldOfPAYBACKUITests.swift
//  WorldOfPAYBACKUITests
//
//  Created by Ramkrishna Baddi on 15/04/2023.
//

import XCTest

final class WorldOfPAYBACKUITests: XCTestCase {
    
    func testHomeView() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Verify that the home view is displayed
        let welcomeText = app.staticTexts["Welcome to the World of PAYBACK"]
        XCTAssertTrue(welcomeText.waitForExistence(timeout: 5))
        
        // Navigate to the transaction list view
        let goButton = app.buttons["Go to Transactions"]
        XCTAssertTrue(goButton.waitForExistence(timeout: 5))
        goButton.tap()
        
        // Verify that the transaction list view is displayed
        let transactionListTitle = app.navigationBars["Transactions"]
        XCTAssertTrue(transactionListTitle.waitForExistence(timeout: 5))
        
        // Return to the home view
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        // Verify that the home view is displayed again
        XCTAssertTrue(welcomeText.waitForExistence(timeout: 5))
    }
}
