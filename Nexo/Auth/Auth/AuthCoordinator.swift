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
    
    private weak var navigationDelegate: FlowNavigator?
    
    public init(navigationController: UINavigationController, navigationDelegate: FlowNavigator?) {
        self.navigationController = navigationController
        self.navigationDelegate = navigationDelegate
        self.networkManager = NetworkManager()
    }
    
    public func start() {
        showLogin()
    }
    
    func goToHome() {
        navigationDelegate?.navigateToHome()
    }
    
    func showLoginErrorAlert(message: String) {
        showCustomAlert(title: "Atenção", message: message)
    }
    
}

// MARK: - Private Functions
extension AuthCoordinator {
    
    private func showLogin() {
        let loginViewController = LoginViewController()
        loginViewController.onLoginSuccess = { [weak self] in
            self?.goToHome()
        }
        let loginService = LoginService(networkManager: networkManager)
        let presenter = LoginPresenter(view: loginViewController)
        let interactor = LoginInteractor(service: loginService, presenter: presenter)
        
        loginViewController.interactor = interactor
        loginViewController.coordinator = self
        
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
}
