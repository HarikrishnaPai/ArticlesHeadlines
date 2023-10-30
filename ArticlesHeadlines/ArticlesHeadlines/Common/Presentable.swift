//
//  Presentable.swift
//  ArticlesHeadlines
//
//  Created by Hari on 29/10/2023.
//

import UIKit

public protocol Presentable {
    func toPresentable() -> UIViewController
}

extension UIViewController: Presentable {
    public func toPresentable() -> UIViewController {
        return self
    }
}
