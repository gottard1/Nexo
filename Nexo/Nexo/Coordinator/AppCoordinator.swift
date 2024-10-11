//
//  AppCoordinator.swift
//  Nexo
//
//  Created by Marcel Felipe Gottardi Anesi on 24/09/24.
//

import UIKit
import Shared
import Auth

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    private var authCoordinator: AuthCoordinator?
    private var tabBarCoordinator: TabBarCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        if isUserAuthenticated() {
            startHomeFlow()
        } else {
            startAuthFlow()
        }
    }
    
    private func isUserAuthenticated() -> Bool {
        // TODO: Verificar se o usuário está autenticado
        return false
    }
    
    private func startAuthFlow() {
        authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator?.start()
    }
    
    private func startHomeFlow() {
        tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator?.start()
    }
}
