//
//  TransactionListViewModelTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Ramkrishna Baddi on 15/04/2023.
//

import Foundation
import Combine
import XCTest

@testable import WorldOfPAYBACK

class TransactionListViewModelTests: XCTestCase {
    var sut: TransactionListViewModel!
    var mockAPIManager: MockAPIManager!
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockAPIManager = MockAPIManager()
        sut = TransactionListViewModel(apiManager: mockAPIManager)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDownWithError() throws {
        mockAPIManager = nil
        sut = nil
        cancellables = nil
        
        try super.tearDownWithError()
    }
    
    func testLoadTransactions_Success() {
        let expectation = XCTestExpectation(description: "load transactions")
        mockAPIManager.response = Just(PBTransactions.mock)
                                    .setFailureType(to: Error.self)
                                    .eraseToAnyPublisher()
        

        sut.$transactions
            .dropFirst()
            .sink { transactions in
                XCTAssertEqual(transactions.count, PBTransactions.mock.transactions.count)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        sut.loadTransactions()

        wait(for: [expectation], timeout: 5.0)
    }
    
    func testLoadTransactions_Error() {
        let expectation = XCTestExpectation(description: "load transactions error")
        mockAPIManager.response = Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        
        sut.$isError
            .dropFirst(2)
            .sink { isError in
                XCTAssertTrue(isError)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.loadTransactions()
        
        wait(for: [expectation], timeout: 1.0)
    }
}
