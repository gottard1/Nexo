//
//  UIView+Extension.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 11/11/24.
//

import UIKit

extension UIView {
    func roundCorners(radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}
