//
//  HeadlineDetailsViewModel.swift
//  ArticlesHeadlinesTests
//
//  Created by Hari on 29/10/2023.
//

import XCTest
@testable import ArticlesHeadlines

final class HeadlineDetailsViewModelTests: XCTestCase {

    // MARK: - Variables
    private var viewModel: HeadlineDetailsViewModel!
    private var userPreference: UserPreference!

    // MARK: - LifeCycle
    override func setUp() {
        super.setUp()
        userPreference = UserPreference(defaults: MockUserDefaults())
        viewModel = HeadlineDetailsViewModel(userPreference: userPreference)
    }

    override func tearDown() {
        super.tearDown()
        userPreference = nil
        viewModel = nil
    }

    // MARK: - Tests
    func testInitialization() {
        XCTAssertNotNil(viewModel, "The Headline Details ViewModel should not be nil")
        XCTAssertNotNil(viewModel.userPreference)
    }
    
    func testIsSavedArticle_whenArticleExists_shouldReturnTrue() throws {
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
        viewModel.article = article2
        
        // When
        let isSavedArticle = viewModel.isSavedArticle()
        
        // Then
        XCTAssertTrue(isSavedArticle)
    }
    
    func testIsSavedArticle_whenArticleDoesNotExists_shouldReturnFalse() throws {
        // Given
        let article1 = Article(title: "title1", description: "description1", author: "author1",
                              url: "url1", urlToImage: "urlToImage1")
        let article2 = Article(title: "title2", description: "description2", author: "author2",
                              url: "url2", urlToImage: "urlToImage2")
        let article3 = Article(title: "title3", description: "description3", author: "author3",
                              url: "url3", urlToImage: "urlToImage3")
        let encodedArticle1 = try XCTUnwrap(JSONEncoder().encode(article1))
        let encodedArticle2 = try XCTUnwrap(JSONEncoder().encode(article2))
        userPreference.savedArticles = [encodedArticle1, encodedArticle2]
        viewModel.article = article3
        
        // When
        let isSavedArticle = viewModel.isSavedArticle()
        
        // Then
        XCTAssertFalse(isSavedArticle)
    }
    
    func testAddOrDeleteArticle_whenArticleExists_shouldDeleteArticle() throws {
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
        viewModel.article = article2
        
        // When
        viewModel.addOrDeleteArticle()
        
        // Then
        XCTAssertEqual(userPreference.savedArticles?.count, 2)
    }
    
    func testAddOrDeleteArticle_whenArticleDoesNotExists_shouldAddArticle() throws {
        // Given
        let article1 = Article(title: "title1", description: "description1", author: "author1",
                              url: "url1", urlToImage: "urlToImage1")
        let article2 = Article(title: "title2", description: "description2", author: "author2",
                              url: "url2", urlToImage: "urlToImage2")
        let article3 = Article(title: "title3", description: "description3", author: "author3",
                              url: "url3", urlToImage: "urlToImage3")
        let encodedArticle1 = try XCTUnwrap(JSONEncoder().encode(article1))
        let encodedArticle2 = try XCTUnwrap(JSONEncoder().encode(article2))
        userPreference.savedArticles = [encodedArticle1, encodedArticle2]
        viewModel.article = article3
        
        // When
        viewModel.addOrDeleteArticle()
        
        // Then
        XCTAssertEqual(userPreference.savedArticles?.count, 3)
    }
    
    func testAddOrDeleteArticle_whenArticleDoesNotExists_andSavedArticlesIsEmpty_shouldAddArticle() throws {
        // Given
        let article1 = Article(title: "title1", description: "description1", author: "author1",
                              url: "url1", urlToImage: "urlToImage1")
        viewModel.article = article1
        
        // When
        viewModel.addOrDeleteArticle()
        
        // Then
        XCTAssertEqual(userPreference.savedArticles?.count, 1)
    }
}
