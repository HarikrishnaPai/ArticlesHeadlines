//
//  UserPreference.swift
//  ArticlesHeadlines
//
//  Created by Hari on 28/10/2023.
//

import Foundation

final class UserPreference {
    
    // MARK: - Variables
    private var defaults: UserDefaults
    
    // MARK: - Initialization
    init(defaults: UserDefaults = UserDefaults.standard) {
        self.defaults = defaults
    }

    // MARK: - Public Methods
    subscript(key: String) -> Any? {
        get {
            return defaults.object(forKey: key)
        }
        set {
            defaults.set(newValue, forKey: key)
        }
    }

    // MARK: - User Preference Keys
    var savedArticles: [Data]? {
        get {
            return self["savedArticles"] as? [Data]
        } set {
            self["savedArticles"] = newValue
        }
    }
    
    var selectedSources: [String]? {
        get {
            return self["selectedSources"] as? [String]
        } set {
            self["selectedSources"] = newValue
        }
    }
}
