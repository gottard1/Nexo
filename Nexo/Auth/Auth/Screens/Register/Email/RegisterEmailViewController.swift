//
//  RegisterEmailViewController.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 09/12/24.
//

import UIKit
import Shared

protocol RegisterEmailViewProtocol: AnyObject {
    func navigateTo(action: AuthActions)
}

class RegisterEmailViewController: UIViewController {
    var interactor: RegisterEmailInteractorProtocol?
    weak var coordinator: AuthCoordinator?
    
    private let mainView: RegisterEmailView = .init()
    
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
        
        mainView.continueButton.addTarget(self, action: #selector(continueButtonAction), for: .touchUpInside)
        mainView.emailTextField.delegate = self
        mainView.confirmEmailTextField.delegate = self
        
#if DEBUG
        mainView.emailTextField.text = "email@email.com"
        mainView.confirmEmailTextField.text = "email@email.com"
        interactor?.userInfo.email = "email@email.com"
        mainView.continueButton.isEnabled = true
#endif
    }
    
}

// MARK: - Actions
extension RegisterEmailViewController {
    
    @objc private func backButtonAction() {
        coordinator?.popRegister()
    }
    
    @objc private func continueButtonAction() {
        guard let userInfo = interactor?.userInfo else {
            coordinator?.showLoginErrorAlert(message: "Ocorreu um erro, tente novamente em instantes")
            return
        }
        interactor?.handleButtonTap(action: .codeValidation(userInfo))
    }
}

// MARK: - Textfield Delegate
extension RegisterEmailViewController: NexoTextFieldDelegate {
    func nexoTextFieldDidChangeSelection(_ textField: NexoTextField) {
        let emailText = mainView.emailTextField.text
        let confirmText = mainView.confirmEmailTextField.text
        let isValidEmail = textField.text?.isValidEmail ?? false
        let areTheSame = emailText == confirmText
        
        mainView.continueButton.isEnabled = isValidEmail && areTheSame
        
        if areTheSame {
            guard let emailText else { return }
            mainView.confirmEmailTextField.warningMessage = isValidEmail ? nil : "Não é um email valido"
            interactor?.userInfo.email = emailText
        } else {
            mainView.confirmEmailTextField.warningMessage = "Os emails devem ser iguais"
        }
    }
}

// MARK: - View protocol
extension RegisterEmailViewController: RegisterEmailViewProtocol {
    func navigateTo(action: AuthActions) {
        coordinator?.handleNavigation(action: action)
    }
}

