//
//  UIView+Extension.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 11/11/24.
//

import UIKit

public extension UIView {
    func roundCorners(radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    /// Part of constraint Maker
    func anchor(_ closure: (ConstraintMaker) -> Void) {
        translatesAutoresizingMaskIntoConstraints = false
        let maker = ConstraintMaker(view: self)
        closure(maker)
        maker.activateConstraints()
    }
}
