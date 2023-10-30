//
//  UIView+Constraints.swift
//  ArticlesHeadlines
//
//  Created by Hari on 27/10/2023.
//

import UIKit

extension UIView {
    
    // MARK: - Public Methods
    func anchor(top: NSLayoutYAxisAnchor?,
                left: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?, 
                right: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat = 0.0,
                paddingLeft: CGFloat = 0.0,
                paddingBottom: CGFloat = 0.0,
                paddingRight: CGFloat = 0.0,
                width: CGFloat = 0.0,
                height: CGFloat = 0.0,
                enableInsets: Bool = false) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
        if height != 0.0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0.0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}
