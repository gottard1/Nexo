//
//  LoginViewController.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 24/09/24.
//

import UIKit
import Shared

final class LoginViewController: UIViewController {
    weak var coordinator: Coordinator?
    var interactor: LoginInteractorProtocol?
    
    private let mainView = LoginView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    private func setupActions() {
        mainView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        guard let username = mainView.usernameTextField.text, !username.isEmpty,
              let password = mainView.passwordTextField.text, !password.isEmpty else {
            displayLoginError("Preencha os campos")
            return
        }
        
        interactor?.login(username: username, password: password)
    }
}

// MARK: - Login Protocol
extension LoginViewController: LoginViewProtocol {
    func displayLoginSuccess(with token: AuthenticateResponse) {
        coordinator.goToHome()
    }
    
    func displayLoginError(_ message: String) {
//        showCustomAlert(
//            title: "Deu erro",
//            message: message,
//            customTitle: "OK",
//            customHandler: {
//                print("okbutton")
//            },
//            cancelTitle: "SAIR") {
//                print("erro button")
//            }
    }
    
}
