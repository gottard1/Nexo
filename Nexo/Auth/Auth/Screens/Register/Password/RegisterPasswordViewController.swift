//
//  PasswordViewController.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 19/12/24.
//

import UIKit
import Shared

protocol RegisterPasswordViewProtocol: AnyObject {
    func displayRegisterSuccess(with token: AuthenticateResponse)
    func displayRegisterError(_ message: String)
}

class RegisterPasswordViewController: UIViewController {
    var interactor: RegisterPasswordInteractorProtocol?
    weak var coordinator: AuthCoordinator?
    
    private let mainView: RegisterPasswordView = .init()
    
    var onRegisterSuccess: (() -> Void)?
    
    override func loadView() {
        view = mainView
        title = "Cadastro"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cadastro"
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(backButtonAction)
        )
        backButton.tintColor = NexoColor.background
        navigationItem.leftBarButtonItem = backButton
        
        mainView.passwordTextField.delegate = self
        mainView.confirmPasswordTextField.delegate = self
        
        mainView.continueButton.addTarget(self, action: #selector(continueButtonButtonAction), for: .touchUpInside)
        
#if DEBUG
        mainView.passwordTextField.text = "Marcel@1d"
        mainView.confirmPasswordTextField.text = "Marcel@1d"
        interactor?.userInfo.password = "Marcel@1d"
        mainView.continueButton.isEnabled = true
#endif
    }
}

// MARK: - Actions
extension RegisterPasswordViewController {
    
    @objc private func backButtonAction() {
        coordinator?.popRegister()
    }
    
    @objc private func continueButtonButtonAction() {
        interactor?.register()
    }
}

// MARK: - Textfield Delegate
extension RegisterPasswordViewController: NexoTextFieldDelegate {
    func nexoTextFieldDidChangeSelection(_ textField: NexoTextField) {
        let isValidPassword = textField.text?.isValidPassword ?? false
        let isTheSame = mainView.passwordTextField.text == mainView.confirmPasswordTextField.text
        
        mainView.continueButton.isEnabled = isValidPassword && isTheSame
        
        if isValidPassword && isTheSame {
            interactor?.userInfo.password = mainView.passwordTextField.text
        }
    }
}

// MARK: - View protocol
extension RegisterPasswordViewController: RegisterPasswordViewProtocol {
    
    func displayRegisterSuccess(with token: AuthenticateResponse) {
        mainView.continueButton.isLoading = false
        
        coordinator?
            .showCustomAlert(
                title: token.message ?? "Bem vindo à Nexo!",
                message: nil,
                customTitle: "Acessar minha conta :)",
                customHandler: {
                    self.onRegisterSuccess?()
                    self.dismiss(animated: true)
                }
            )
    }
    
    func displayRegisterError(_ message: String) {
        mainView.continueButton.isLoading = false
        
        coordinator?.showLoginErrorAlert(message: message)
    }
}
