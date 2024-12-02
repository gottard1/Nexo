//
//  AuthCoordinator.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 24/09/24.
//

import UIKit
import Shared

enum AuthActions {
    case login
    case register
    case status
}

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
//        goToLogin()
        showOnboarding()
    }
    
    func handleNavigation(action: AuthActions) {
        switch action {
            case .login:
                goToLogin()
            case .register:
                goToRegister()
            case .status:
                goToAccountStatus()
        }
    }
    
    func showLoginErrorAlert(message: String) {
        showCustomAlert(title: "Atenção", message: message)
    }
}

// MARK: - Private Functions
extension AuthCoordinator {
    
    private func showOnboarding() {
        let onboardingViewController = OnboardingViewController()
        let presenter = OnboardingPresenter()
        let interactor = OnboardingInteractor(presenter: presenter, view: onboardingViewController)
        
        onboardingViewController.interactor = interactor
        onboardingViewController.coordinator = self
        
        navigationController.setViewControllers([onboardingViewController], animated: false)
    }
    
    private func goToHome() {
        navigationDelegate?.navigateToHome()
    }
    
    private func goToLogin() {
        let loginViewController = LoginViewController()
        loginViewController.onLoginSuccess = { [weak self] in
            self?.goToHome()
        }
        let loginService = LoginService(networkManager: networkManager)
        let presenter = LoginPresenter(view: loginViewController)
        let interactor = LoginInteractor(service: loginService, presenter: presenter)
        
        loginViewController.interactor = interactor
        loginViewController.coordinator = self
        
//        navigationController.setViewControllers([loginViewController], animated: false)
        
        let loginNavigationController = UINavigationController(rootViewController: loginViewController)
        loginNavigationController.modalPresentationStyle = .fullScreen
        
        navigationController.present(loginNavigationController, animated: true)
    }
    
    private func goToRegister() {
        let registerVC = UIViewController()
        registerVC.view.backgroundColor = .green
        registerVC.title = "Register"
        navigationController.pushViewController(registerVC, animated: true)
    }
    
    private func goToAccountStatus() {
        let accountVC = UIViewController()
        accountVC.view.backgroundColor = .blue
        accountVC.title = "Acompanhar Conta"
        navigationController.pushViewController(accountVC, animated: true)
    }
    
}
