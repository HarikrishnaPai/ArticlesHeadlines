//
//  SavedHeadlinesViewModelTests.swift
//  ArticlesHeadlinesTests
//
//  Created by Hari on 29/10/2023.
//

import XCTest
@testable import ArticlesHeadlines

final class SavedHeadlinesViewModelTests: XCTestCase {

    // MARK: - Variables
    private var viewModel: SavedHeadlinesViewModel!
    private var userPreference: UserPreference!

    // MARK: - LifeCycle
    override func setUp() {
        super.setUp()
        userPreference = UserPreference(defaults: MockUserDefaults())
        viewModel = SavedHeadlinesViewModel(userPreference: userPreference)
    }

    override func tearDown() {
        super.tearDown()
        userPreference = nil
        viewModel = nil
    }

    // MARK: - Tests
    func testInitialization() {
        XCTAssertNotNil(viewModel, "The Saved Headlines ViewModel should not be nil")
        XCTAssertNotNil(viewModel.userPreference)
        XCTAssertNotNil(viewModel.articles)
    }
    
    func testGetSavedHeadlines() throws {
        // Given
        let article1 = Article(title: "title1", description: "description1", author: "author1",
                              url: "url1", urlToImage: "urlToImage1")
        let article2 = Article(title: "title2", description: "description2", author: "author2",
                              url: "url2", urlToImage: "urlToImage2")
        let article3 = Article(title: "title3", description: "description3", author: "author3",
                              url: "url3", urlToImage: "urlToImage3")
        let encodedArticle1 = try XCTUnwrap(JSONEncoder().encode(article1))
        let encodedArticle2 = try XCTUnwrap(JSONEncoder().encode(article2))
        let encodedArticle3 = try XCTUnwrap(JSONEncoder().encode(article3))
        userPreference.savedArticles = [encodedArticle1, encodedArticle2, encodedArticle3]
        
        // When
        viewModel.getSavedHeadlines()
        
        // Then
        XCTAssertNotNil(viewModel.articles)
    }
}
