//
//  UIView+Extension.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 11/11/24.
//

import UIKit

public extension UIView {
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
    
    /// Part of constraint Maker
    func anchor(_ closure: (ConstraintMaker) -> Void) {
        translatesAutoresizingMaskIntoConstraints = false
        let maker = ConstraintMaker(view: self)
        closure(maker)
        maker.activateConstraints()
    }
}
