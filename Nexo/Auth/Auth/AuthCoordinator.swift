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
    case registerInitial
    case registerDocument
    case registerEmail(_ info: RegisterModel)
    case registerPassword(_ info: RegisterModel)
    case status
}

public final class AuthCoordinator: Coordinator {
    public var navigationController: UINavigationController
    private let networkManager: Networking
    
    private var registerNavigationController: UINavigationController?
    
    private weak var navigationDelegate: FlowNavigator?
    
    public init(navigationController: UINavigationController, navigationDelegate: FlowNavigator?) {
        self.navigationController = navigationController
        self.navigationDelegate = navigationDelegate
        self.networkManager = NetworkManager()
    }
    
    public func start() {
        showOnboarding()
    }
    
    func handleNavigation(action: AuthActions) {
        switch action {
            case .login:
                goToLogin()
            case .registerInitial:
                goToRegister()
            case .registerDocument:
                goToRegisterDocument()
            case .registerEmail(let object):
                goToRegisterEmail(with: object)
            case .registerPassword(let object):
                goToRegisterPassword(with: object)
            case .status:
                goToAccountStatus()
        }
    }
    
    func dismissLogin() {
        navigationController.dismiss(animated: true)
    }
    
    func dismissRegister() {
        registerNavigationController?.dismiss(animated: true)
    }
    
    func popRegister() {
        registerNavigationController?.popViewController(animated: true)
    }
    
    func showLoginErrorAlert(message: String) {
        showCustomAlert(title: "Atenção", message: message)
    }
}

// MARK: - Private Functions
extension AuthCoordinator {
    
    private func showOnboarding() {
        let viewController = OnboardingViewController()
        let presenter = OnboardingPresenter()
        let interactor = OnboardingInteractor(presenter: presenter, view: viewController)
        
        viewController.interactor = interactor
        viewController.coordinator = self
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    private func goToHome() {
        navigationDelegate?.navigateToHome()
    }
    
    private func goToLogin() {
        let viewController = LoginViewController()
        viewController.onLoginSuccess = { [weak self] in
            self?.goToHome()
        }
        let loginService = LoginService(networkManager: networkManager)
        let presenter = LoginPresenter(view: viewController)
        let interactor = LoginInteractor(service: loginService, presenter: presenter)
        
        viewController.interactor = interactor
        viewController.coordinator = self
        
        let loginNavigationController = UINavigationController(rootViewController: viewController)
        loginNavigationController.modalPresentationStyle = .fullScreen
        
        navigationController.present(loginNavigationController, animated: true)
    }
    
    private func goToRegister() {
        let viewController = RegisterInitialViewController()
        
        let presenter = RegisterInitialPresenter(view: viewController)
        let interactor = RegisterInitialInteractor(presenter: presenter)
        
        viewController.interactor = interactor
        viewController.coordinator = self
        
        let registerNavigationController = UINavigationController(rootViewController: viewController)
        registerNavigationController.modalPresentationStyle = .fullScreen
        self.registerNavigationController = registerNavigationController
        
        navigationController.present(registerNavigationController, animated: true)
    }
    
    private func goToRegisterDocument() {
        guard let registerNavigationController else { return }
        
        let viewController = RegisterDocumentViewController()
        
        let presenter = RegisterDocumentPresenter(view: viewController)
        let interactor = RegisterDocumentInteractor(presenter: presenter)
        
        viewController.interactor = interactor
        viewController.coordinator = self
        
        registerNavigationController.pushViewController(viewController, animated: true)
    }
    
    private func goToRegisterEmail(with info: RegisterModel) {
        guard let registerNavigationController else { return }
        
        let viewController = RegisterEmailViewController()
        
        let presenter = RegisterEmailPresenter(view: viewController)
        let interactor = RegisterEmailInteractor(presenter: presenter, with: info)
        
        viewController.interactor = interactor
        viewController.coordinator = self
        
        registerNavigationController.pushViewController(viewController, animated: true)
    }
    
    private func goToRegisterPassword(with info: RegisterModel) {
        guard let registerNavigationController else { return }
        
        let registerDocumentViewController = RegisterDocumentViewController()
        
        let presenter = RegisterDocumentPresenter(view: registerDocumentViewController)
        let interactor = RegisterDocumentInteractor(presenter: presenter)
        
        registerDocumentViewController.interactor = interactor
        registerDocumentViewController.coordinator = self
        
        registerNavigationController.pushViewController(registerDocumentViewController, animated: true)
    }
    
    private func goToAccountStatus() {
        let accountVC = UIViewController()
        accountVC.view.backgroundColor = .blue
        accountVC.title = "Acompanhar Conta"
        navigationController.pushViewController(accountVC, animated: true)
    }
    
}
