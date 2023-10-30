//
//  TabBarController.swift
//  ArticlesHeadlines
//
//  Created by Hari on 27/10/2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
    }
}
