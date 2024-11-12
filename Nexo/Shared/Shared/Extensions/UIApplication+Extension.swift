//
//  UIApplication+Extension.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 12/11/24.
//

import UIKit

extension UIApplication {
    public static func currentViewController(_ base: UIViewController? = UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .first?.windows
        .first(where: { $0.isKeyWindow })?.rootViewController) -> UIViewController? {
            
            if let nav = base as? UINavigationController {
                return currentViewController(nav.visibleViewController)
            }
            
            if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
                return currentViewController(selected)
            }
            
            if let presented = base?.presentedViewController {
                return currentViewController(presented)
            }
            
            return base
        }
}
