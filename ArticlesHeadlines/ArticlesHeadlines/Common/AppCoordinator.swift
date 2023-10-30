//
//  AppCoordinator.swift
//  ArticlesHeadlines
//
//  Created by Hari on 28/10/2023.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Variables
    let tabBarController = TabBarController()
    var tabs: [UIViewController: Coordinator] = [:]
    var selectedTabIndex: Int = 0
    
    lazy var homeCoordinator: HeadlinesCoordinator = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem.title = String(localized: "toolbar.button.headlines")
        navigationController.tabBarItem.image = UIImage(named: "HeadlinesIcon")
        navigationController.navigationBar.prefersLargeTitles = true
        let router = Router(navigationController: navigationController)
        let coordinator = HeadlinesCoordinator(router: router)
        return coordinator
    }()
    
    lazy var sourcesCoordinator: SourcesCoordinator = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem.title = String(localized: "toolbar.button.sources")
        navigationController.tabBarItem.image = UIImage(named: "SourcesIcon")
        navigationController.navigationBar.prefersLargeTitles = true
        let router = Router(navigationController: navigationController)
        let coordinator = SourcesCoordinator(router: router)
        return coordinator
    }()
    
    lazy var savedHeadlinesCoordinator: SavedHeadlinesCoordinator = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem.title = String(localized: "toolbar.button.saved")
        navigationController.tabBarItem.image = UIImage(named: "SaveIcon")
        navigationController.navigationBar.prefersLargeTitles = true
        let router = Router(navigationController: navigationController)
        let coordinator = SavedHeadlinesCoordinator(router: router)
        return coordinator
    }()
    
    // MARK: - Initialization
    override init(router: RouterType) {
        super.init(router: router)
        router.setRootModule(tabBarController, hideBar: true)
        tabBarController.delegate = self
        setTabs([homeCoordinator,
                 sourcesCoordinator,
                 savedHeadlinesCoordinator])
    }
    
    // MARK: - Private Methods
    private func setTabs(_ coordinators: [Coordinator], animated: Bool = false) {
        tabs = [:]
        
        // Store view controller to coordinator mapping
        let vcs = coordinators.map { coordinator -> UIViewController in
            let viewController = coordinator.toPresentable()
            tabs[viewController] = coordinator
            return viewController
        }
        
        tabBarController.setViewControllers(vcs, animated: animated)
    }
}

// MARK: - UITabBarControllerDelegate
extension AppCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController),
              selectedIndex != selectedTabIndex else {
            /// Same tab selected again , hence do nothing.
            return
        }
        let navigationController = viewController as? UINavigationController
        switch navigationController?.viewControllers.first {
        case let viewController as HeadlinesViewController:
            viewController.loadData()
            selectedTabIndex = 0
        case let viewController as SourcesViewController:
            viewController.loadData()
            selectedTabIndex = 1
        case let viewController as SavedHeadlinesViewController:
            viewController.loadData()
            selectedTabIndex = 2
        default:
            break
        }
    }
}
