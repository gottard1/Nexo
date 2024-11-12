//
//  AuthCoordinator.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 24/09/24.
//

import UIKit
import Shared

public final class AuthCoordinator: Coordinator {
    public var navigationController: UINavigationController
    private let networkManager: Networking
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.networkManager = NetworkManager()
    }
    
    public func start() {
        showLogin()
    }
    
    func goToHome() {
        
    }
    
    func showLoginErrorAlert(message: String) {
        showCustomAlert(title: "Atenção", message: message)
    }
    
}

// MARK: - Private Functions
extension AuthCoordinator {
    
    private func showLogin() {
        let loginService = LoginService(networkManager: networkManager)
        let loginViewController = LoginViewController()
        let presenter = LoginPresenter(view: loginViewController)
        let interactor = LoginInteractor(service: loginService, presenter: presenter)
        
        loginViewController.interactor = interactor
        loginViewController.coordinator = self
        
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
}
