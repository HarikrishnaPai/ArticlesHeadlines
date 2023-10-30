//
//  MockUserDefaults.swift
//  ArticlesHeadlinesTests
//
//  Created by Hari on 29/10/2023.
//

import XCTest
@testable import ArticlesHeadlines

class MockUserDefaults: UserDefaults {
    convenience init() {
        self.init(suiteName: "MockUserDefaults")!
    }
    
    override init?(suiteName suitename: String?) {
        UserDefaults().removePersistentDomain(forName: suitename!)
        super.init(suiteName: suitename)
    }
}
