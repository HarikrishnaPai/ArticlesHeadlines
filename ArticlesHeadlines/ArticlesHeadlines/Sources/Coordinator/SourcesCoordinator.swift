//
//  SourcesCoordinator.swift
//  ArticlesHeadlines
//
//  Created by Hari on 28/10/2023.
//

import UIKit

class SourcesCoordinator: Coordinator {
    
    // MARK: - Variables
    lazy var sourcesViewController: SourcesViewController = {
        let controller = SourcesViewController()
        controller.navigationItem.title = String(localized: "toolbar.button.sources")
        return controller
    }()

    // MARK: - Initialization
    override init(router: RouterType) {
        super.init(router: router)
        router.setRootModule(sourcesViewController, hideBar: false)
    }
}
