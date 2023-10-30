//
//  SavedHeadlinesViewModel.swift
//  ArticlesHeadlines
//
//  Created by Hari on 28/10/2023.
//

import Foundation
import RxSwift

class SavedHeadlinesViewModel: NSObject {
    
    // MARK: - Variables
    var articles = PublishSubject<[Article]>()
    var userPreference: UserPreference!

    // MARK: - Initialization
    init(userPreference: UserPreference = UserPreference(defaults: UserDefaults.standard)) {
        super.init()
        self.userPreference = userPreference
    }
}

// MARK: - Public Methods
extension SavedHeadlinesViewModel {
    func getSavedHeadlines() {
        guard let articles = userPreference.savedArticles?.map({ try? JSONDecoder().decode(Article.self, from: $0) }) else {
            self.articles.onNext([])
            return
        }
        let data = articles.compactMap { $0 }
        self.articles.onNext(data)
    }
}
