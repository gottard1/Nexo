//
//  AuthCoordinator.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 24/09/24.
//

import UIKit

public final class AuthCoordinator {
    private let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let loginViewController = LoginViewController()
        
        print(navigationController.viewControllers.count)
        
        navigationController.pushViewController(loginViewController, animated: true)
    }
}
