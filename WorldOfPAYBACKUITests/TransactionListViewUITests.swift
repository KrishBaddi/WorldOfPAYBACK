//
//  TransactionListViewUITests.swift
//  WorldOfPAYBACKUITests
//
//  Created by Ramkrishna Baddi on 19/04/2023.
//

import XCTest
@testable import WorldOfPAYBACK

final class TransactionListViewUITests: XCTestCase {
    func testTransactionList() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Navigate to the transaction list view
        let goButton = app.buttons["Go to Transactions"]
        XCTAssertTrue(goButton.waitForExistence(timeout: 5))
        goButton.tap()
        
        // Wait for the view to appear
        let transactionListTitle = app.navigationBars["Transactions"]
        XCTAssertTrue(transactionListTitle.waitForExistence(timeout: 5))
        
        // Verify that the list is initially empty
        XCTAssertTrue(app.tables.cells.count == 0)
        
   
        // Wait for data to be loaded
        XCTAssertTrue(app.tables.cells.count > 0)
        
        // Get a reference to the view model
           let viewModel = TransactionListViewModel()

           // Call the mockData() function on the view model
           viewModel.mockRandomly()

           // Verify that the transaction list view is displaying some transactions
           let table = app.tables["TransactionList"]
           XCTAssertTrue(table.cells.count > 0)
    }
}
