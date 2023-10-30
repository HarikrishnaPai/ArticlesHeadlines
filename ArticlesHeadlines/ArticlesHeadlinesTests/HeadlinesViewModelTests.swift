//
//  HeadlinesViewModelTests.swift
//  ArticlesHeadlinesTests
//
//  Created by Hari on 29/10/2023.
//

import XCTest
@testable import ArticlesHeadlines
@testable import Networking

final class HeadlinesViewModelTests: XCTestCase {

    // MARK: - Variables
    private var viewModel: HeadlinesViewModel!
    private var networkManager: NetworkManagerProtocol!
    private var userPreference: UserPreference!

    // MARK: - LifeCycle
    override func setUp() {
        super.setUp()
        networkManager = MockNetworkManager()
        userPreference = UserPreference(defaults: MockUserDefaults())
        viewModel = HeadlinesViewModel(networkManager: networkManager, userPreference: userPreference)
    }

    override func tearDown() {
        super.tearDown()
        networkManager = nil
        userPreference = nil
        viewModel = nil
    }

    // MARK: - Tests
    func testInitialization() {
        XCTAssertNotNil(viewModel, "The Headlines ViewModel should not be nil")
        XCTAssertNotNil(viewModel.networkManager)
        XCTAssertNotNil(viewModel.userPreference)
        XCTAssertNotNil(viewModel.articles)
        XCTAssertNotNil(viewModel.error)
    }
    
    func testGetTopHeadlines() throws {
        // Given
        let expectation = XCTestExpectation()
        expectation.isInverted = true
        let networkManager = try XCTUnwrap(viewModel.networkManager as? MockNetworkManager)
        let stubbedArticles = Articles()
        networkManager.addStubbedResult(stubbedArticles)
        
        // When
        viewModel.getTopHeadlines()
        wait(for: [expectation], timeout: 0.1)
        
        // Then
        XCTAssertEqual(networkManager.performRequestCalledCount, 1)
        XCTAssertNotNil(networkManager.requestEndpoint)
    }
}
