//
//  SourcesViewModelTests.swift
//  ArticlesHeadlinesTests
//
//  Created by Hari on 29/10/2023.
//

import XCTest
@testable import ArticlesHeadlines
@testable import Networking

final class SourcesViewModelTests: XCTestCase {

    // MARK: - Variables
    private var viewModel: SourcesViewModel!
    private var networkManager: NetworkManagerProtocol!
    private var userPreference: UserPreference!

    // MARK: - LifeCycle
    override func setUp() {
        super.setUp()
        networkManager = MockNetworkManager()
        userPreference = UserPreference(defaults: MockUserDefaults())
        viewModel = SourcesViewModel(networkManager: networkManager, userPreference: userPreference)
    }

    override func tearDown() {
        super.tearDown()
        networkManager = nil
        userPreference = nil
        viewModel = nil
    }

    // MARK: - Tests
    func testInitialization() {
        XCTAssertNotNil(viewModel, "The Sources ViewModel should not be nil")
        XCTAssertNotNil(viewModel.networkManager)
        XCTAssertNotNil(viewModel.userPreference)
        XCTAssertNotNil(viewModel.sources)
        XCTAssertNotNil(viewModel.error)
    }
    
    func testGetSources() throws {
        // Given
        let expectation = XCTestExpectation()
        expectation.isInverted = true
        let networkManager = try XCTUnwrap(viewModel.networkManager as? MockNetworkManager)
        let stubbedSources = Sources()
        networkManager.addStubbedResult(stubbedSources)
        
        // When
        viewModel.getSources()
        wait(for: [expectation], timeout: 0.1)
        
        // Then
        XCTAssertEqual(networkManager.performRequestCalledCount, 1)
        XCTAssertNotNil(networkManager.requestEndpoint)
    }
    
    func isSourceSelected(_ source: Source) -> Bool {
        let isSourceSelected = userPreference.selectedSources?.contains { $0 == source.sourceId } ?? false
        return isSourceSelected
    }
    
    func testIsSourceSelected_whenSourceExists_shouldReturnTrue() throws {
        // Given
        let source1 = Source(sourceId: "sourceId1", name: "name1", url: "url1")
        userPreference.selectedSources = ["sourceId1", "sourceId2", "sourceId3"]
        
        // When
        let isSourceSelected = viewModel.isSourceSelected(source1)
        
        // Then
        XCTAssertTrue(isSourceSelected)
    }
    
    func testIsSourceSelected_whenSourceDoesNotExists_shouldReturnFalse() throws {
        // Given
        let source4 = Source(sourceId: "sourceId4", name: "name4", url: "url4")
        userPreference.selectedSources = ["sourceId1", "sourceId2", "sourceId3"]
        
        // When
        let isSourceSelected = viewModel.isSourceSelected(source4)
        
        // Then
        XCTAssertFalse(isSourceSelected)
    }
    
    func testSaveSource_whenSourceDoesNotExists_shouldSaveSource() throws {
        // Given
        let source4 = Source(sourceId: "sourceId4", name: "name4", url: "url4")
        userPreference.selectedSources = ["sourceId1", "sourceId2", "sourceId3"]
        
        // When
        viewModel.saveSource(source4)
        
        // Then
        XCTAssertEqual(userPreference.selectedSources?.count, 4)
    }
    
    func testSaveSource_whenSourceExists_shouldNotSaveSource() throws {
        // Given
        let source1 = Source(sourceId: "sourceId1", name: "name1", url: "url1")
        userPreference.selectedSources = ["sourceId1", "sourceId2", "sourceId3"]
        
        // When
        viewModel.saveSource(source1)
        
        // Then
        XCTAssertEqual(userPreference.selectedSources?.count, 3)
    }
    
    func testDeleteSource_whenSourceExists_shouldDeleteSource() throws {
        // Given
        let source1 = Source(sourceId: "sourceId1", name: "name1", url: "url1")
        userPreference.selectedSources = ["sourceId1", "sourceId2", "sourceId3"]
        
        // When
        viewModel.deleteSource(source1)
        
        // Then
        XCTAssertEqual(userPreference.selectedSources?.count, 2)
    }
    
    func testDeleteSource_whenSourceDoesNotExists_shouldNotDeleteSource() throws {
        // Given
        let source4 = Source(sourceId: "sourceId4", name: "name4", url: "url4")
        userPreference.selectedSources = ["sourceId1", "sourceId2", "sourceId3"]
        
        // When
        viewModel.deleteSource(source4)
        
        // Then
        XCTAssertEqual(userPreference.selectedSources?.count, 3)
    }
}
