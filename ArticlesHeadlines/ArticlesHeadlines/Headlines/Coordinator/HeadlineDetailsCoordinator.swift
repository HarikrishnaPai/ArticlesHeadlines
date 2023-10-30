//
//  HeadlineDetailsCoordinator.swift
//  ArticlesHeadlines
//
//  Created by Hari on 28/10/2023.
//

import UIKit

class HeadlineDetailsCoordinator: Coordinator {
    
    // MARK: - Variables
    lazy var headlineDetailsViewController: HeadlineDetailsViewController = {
        let controller = HeadlineDetailsViewController()
        return controller
    }()
    var article: Article?

    // MARK: - Initialization
    init(router: RouterType, article: Article?) {
        self.article = article
        super.init(router: router)
        self.headlineDetailsViewController.headlineDetailsViewModel.article = article
    }
    
    override func toPresentable() -> UIViewController {
        return headlineDetailsViewController
    }
}
