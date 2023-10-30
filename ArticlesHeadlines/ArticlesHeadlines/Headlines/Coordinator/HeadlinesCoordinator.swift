//
//  HeadlinesCoordinator.swift
//  ArticlesHeadlines
//
//  Created by Hari on 28/10/2023.
//

import UIKit

class HeadlinesCoordinator: Coordinator {
    
    // MARK: - Variables
    lazy var headlinesViewController: HeadlinesViewController = {
        let controller = HeadlinesViewController()
        controller.navigationItem.title = String(localized: "toolbar.button.headlines")
        controller.coordinator = self
        return controller
    }()

    // MARK: - Initialization
    override init(router: RouterType) {
        super.init(router: router)
        router.setRootModule(headlinesViewController, hideBar: false)
    }
}

// MARK: - Public Methods
extension HeadlinesCoordinator {
    func displayHeadlineDetails(article: Article?) {
        let coordinator = HeadlineDetailsCoordinator(router: router, article: article)
        addChild(coordinator)
        coordinator.start()
        router.push(coordinator, animated: true) { [weak self, weak coordinator] in
            guard let self, let coordinator else { return }
            self.removeChild(coordinator)
        }
    }
}
