//
//  UIPresentationController+Extension.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 11/11/24.
//

import UIKit

extension UIPresentationController {
    
    func updatePresentationLayout(animated: Bool = false) {
        containerView?.setNeedsLayout()
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                self.containerView?.layoutIfNeeded()
            }, completion: nil)
        } else {
            containerView?.layoutIfNeeded()
        }
    }
}
