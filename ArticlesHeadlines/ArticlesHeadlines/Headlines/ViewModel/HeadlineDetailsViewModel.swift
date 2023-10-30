//
//  HeadlineDetailsViewModel.swift
//  ArticlesHeadlines
//
//  Created by Hari on 28/10/2023.
//

import Foundation

class HeadlineDetailsViewModel: NSObject {
    
    // MARK: - Variables
    var article: Article?
    var userPreference: UserPreference!

    // MARK: - Initialization
    init(userPreference: UserPreference = UserPreference(defaults: UserDefaults.standard)) {
        super.init()
        self.userPreference = userPreference
    }
}

// MARK: - Public Methods
extension HeadlineDetailsViewModel {
    func isSavedArticle() -> Bool {
        let isSavedArticle = userPreference?.savedArticles?.contains(where: { articleData in
            let article = try? JSONDecoder().decode(Article.self, from: articleData)
            return article?.url == self.article?.url
        })
        return isSavedArticle ?? false
    }
    
    func addOrDeleteArticle() {
        if isSavedArticle() {
            // Delete the article from User Preference
            userPreference?.savedArticles = userPreference?.savedArticles?.filter({ articleData in
                let savedArticle = try? JSONDecoder().decode(Article.self, from: articleData)
                return article?.url != savedArticle?.url
            })
        } else {
            // Add the article to User Preference
            guard let article, let articleData = try? JSONEncoder().encode(article) else { return }
            guard let savedArticles = userPreference?.savedArticles else {
                userPreference?.savedArticles = [ articleData ]
                return
            }
            userPreference?.savedArticles = savedArticles + [ articleData ]
        }
    }
}
