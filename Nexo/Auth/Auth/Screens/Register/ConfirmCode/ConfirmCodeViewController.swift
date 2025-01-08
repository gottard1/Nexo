//
//  ConfirmCodeViewController.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 13/12/24.
//

import UIKit
import Shared

protocol ConfirmCodeViewProtocol: AnyObject {
    func navigateTo(action: AuthActions)
    func showErrorAlert(with message: String)
}

class ConfirmCodeViewController: UIViewController {
    var interactor: ConfirmCodeInteractorProtocol?
    weak var coordinator: AuthCoordinator?
    
    private let mainView: ConfirmCodeView = .init()
    
    private var timer: Timer?
    private var timeRemaining = 60
    
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
        
        mainView.reSendButton.addTarget(self, action: #selector(reSendButtonAction), for: .touchUpInside)
        mainView.codeTextInput.delegate = self
        
        startResendTimer()
    }
}

// MARK: - Code input delegate
extension ConfirmCodeViewController: CodeInputFieldDelegate {
    
    func didEnterCode(_ code: String) {
        guard let userInfo = interactor?.userInfo else {
            coordinator?.showLoginErrorAlert(message: "Ocorreu um erro, tente novamente em instantes")
            return
        }
        let code = ValidateCodeModel(code: code)
        
        interactor?.validateCode(
            code: code,
            successAction: .registerPassword(userInfo)
        )
    }
    
}

// MARK: - Actions
extension ConfirmCodeViewController {
    
    private func startResendTimer() {
        mainView.reSendButton.isEnabled = false
        timeRemaining = 45
        updateResendButtonTitle()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    private func updateResendButtonTitle() {
        let title: String = timeRemaining > 0 ? "Reenviar código em \(timeRemaining)s" : "Enviar novo código"
        mainView.reSendButton.setTitle(title, for: .normal)
    }
    
    @objc private func updateTimer() {
        timeRemaining -= 1
        updateResendButtonTitle()
        
        if timeRemaining <= 0 {
            timer?.invalidate()
            timer = nil
            mainView.reSendButton.isEnabled = true
        }
    }
    
    @objc private func backButtonAction() {
        coordinator?.popRegister()
    }
    
    @objc private func reSendButtonAction() {
        interactor?.resendCode()
    }
}

// MARK: - View protocol
extension ConfirmCodeViewController: ConfirmCodeViewProtocol {
    func navigateTo(action: AuthActions) {
        coordinator?.handleNavigation(action: action)
    }
    
    func showErrorAlert(with message: String) {
        coordinator?.showLoginErrorAlert(message: message)
    }
}
