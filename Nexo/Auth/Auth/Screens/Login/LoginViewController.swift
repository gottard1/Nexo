//
//  LoginViewController.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 24/09/24.
//

import UIKit
import Shared

protocol LoginViewProtocol: AnyObject {
    func displayLoginSuccess(with token: AuthenticateResponse)
    func displayLoginError(_ message: String)
}

final class LoginViewController: UIViewController {
    weak var coordinator: AuthCoordinator?
    var interactor: LoginInteractorProtocol?
    
    private let mainView = LoginView()
    
    var onLoginSuccess: (() -> Void)?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(backButtonAction)
        )
        backButton.tintColor = NexoColor.background
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupActions() {
        mainView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension LoginViewController {
    
    @objc private func backButtonAction() {
        coordinator?.dismissLogin()
    }
    
    @objc private func loginButtonTapped() {
        guard let username = mainView.usernameTextField.text?.onlyDigits, !username.isEmpty,
              let password = mainView.passwordTextField.text, !password.isEmpty else {
            displayLoginError("Preencha os campos")
            return
        }
        
        mainView.loginButton.isLoading = true
        
        interactor?.login(username: username, password: password)
    }
}

// MARK: - Login Protocol
extension LoginViewController: LoginViewProtocol {
    func displayLoginSuccess(with token: AuthenticateResponse) {
        mainView.loginButton.isLoading = false
        
        onLoginSuccess?()
        dismiss(animated: true)
    }
    
    func displayLoginError(_ message: String) {
        mainView.loginButton.isLoading = false
        
        coordinator?.showLoginErrorAlert(message: message)
    }
}
