//
//  RegisterDocumentViewController.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 06/12/24.
//

import UIKit
import Shared

protocol RegisterDocumentViewProtocol: AnyObject {
    func navigateTo(action: AuthActions)
}

class RegisterDocumentViewController: UIViewController {
    var interactor: RegisterDocumentInteractorProtocol?
    weak var coordinator: AuthCoordinator?
    
    private let mainView: RegisterDocumentView = .init()
    
    override func loadView() {
        view = mainView
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
        mainView.usernameTextField.delegate = self
    }
    
}

// MARK: - Actions
extension RegisterDocumentViewController {
    
    @objc private func backButtonAction() {
        coordinator?.popRegister()
    }
    
    @objc private func continueButtonAction() {
        let document = mainView.usernameTextField.text?.onlyDigits
        let info = RegisterModel(cpfCnpj: document)
        interactor?.handleButtonTap(action: .registerEmail(info))
    }
}

// MARK: - Textfield Delegate
extension RegisterDocumentViewController: NexoTextFieldDelegate {
    func nexoTextFieldDidChangeSelection(_ textField: NexoTextField) {
        mainView.continueButton.isEnabled = textField.text?.isValidCPFOrCNPJ ?? false
    }
}

// MARK: - View protocol
extension RegisterDocumentViewController: RegisterDocumentViewProtocol {
    func navigateTo(action: AuthActions) {
        coordinator?.handleNavigation(action: action)
    }
}
