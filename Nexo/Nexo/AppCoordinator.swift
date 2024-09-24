//
//  AppCoordinator.swift
//  Nexo
//
//  Created by Marcel Felipe Gottardi Anesi on 24/09/24.
//

import UIKit

public final class AppCoordinator {
    private let navigationController: UINavigationController
    private var authCoordinator: AuthCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if isUserAuthenticated() {
            // TODO: iniciarHomeFlow()
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
}
