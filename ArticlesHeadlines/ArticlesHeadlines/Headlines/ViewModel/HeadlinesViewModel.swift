//
//  HeadlinesViewModel.swift
//  ArticlesHeadlines
//
//  Created by Hari on 27/10/2023.
//

import Foundation
import RxSwift
import Networking

class HeadlinesViewModel: NSObject {
    
    // MARK: - Variables
    var networkManager: NetworkManagerProtocol!
    let articles = PublishSubject<[Article]>()
    let error = PublishSubject<Error>()
    var userPreference: UserPreference!

    // MARK: - Initialization
    init(networkManager: NetworkManagerProtocol = NetworkManager(),
         userPreference: UserPreference = UserPreference()) {
        super.init()
        self.networkManager = networkManager
        self.userPreference = userPreference
    }
}

// MARK: - Public Methods
extension HeadlinesViewModel {
    func getTopHeadlines() {
        Task { [weak self] in
            do {
                let sources = self?.userPreference?.selectedSources?.joined(separator: ",")
                let endpoint = NewsAPIEndpoints.Headlines.top(sources: sources)
                let response = try await self?.networkManager.performRequest(for: endpoint, responseModel: Articles.self)
                if let articles = response?.articles {
                    /// Filter any articles which are in "Removed" status
                    let filteredArticles = articles.filter { $0.title != "[Removed]" }
                    self?.articles.onNext(filteredArticles)
                }
            } catch {
                self?.error.onNext(error)
            }
        }
    }
}
