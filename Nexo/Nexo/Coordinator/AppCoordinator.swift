//
//  AppCoordinator.swift
//  Nexo
//
//  Created by Marcel Felipe Gottardi Anesi on 24/09/24.
//

import UIKit
import Shared
import Auth

final class AppCoordinator: Coordinator, FlowNavigator {
    var navigationController: UINavigationController
    
    private var authCoordinator: AuthCoordinator?
    private var tabBarCoordinator: TabBarCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        if isUserAuthenticated() {
            navigateToHome()
        } else {
            navigateToAuth()
        }
    }
    
    private func isUserAuthenticated() -> Bool {
//        return false
        return true
    }
    
    func navigateToAuth() {
        authCoordinator = AuthCoordinator(navigationController: navigationController, navigationDelegate: self)
        authCoordinator?.start()
    }
    
    func navigateToHome() {
        tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator?.start()
    }
}
