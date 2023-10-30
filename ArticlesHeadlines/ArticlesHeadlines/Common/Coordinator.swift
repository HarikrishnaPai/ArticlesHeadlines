//
//  Coordinator.swift
//  ArticlesHeadlines
//
//  Created by Hari on 28/10/2023.
//

import UIKit

public protocol Coordinatable: AnyObject, Presentable {
    var router: RouterType { get }
    func start()
}

open class Coordinator: NSObject, Coordinatable {
    // MARK: - Variables
    public var childCoordinators: [Coordinator] = []
    public var router: RouterType

    // MARK: - Initialization
    public init(router: RouterType) {
        self.router = router
        super.init()
    }
    
    // MARK: - Public Methods
    open func start() {}
    
    open func toPresentable() -> UIViewController {
        return router.toPresentable()
    }
    
    public func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    public func removeChild(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        }
    }
}
