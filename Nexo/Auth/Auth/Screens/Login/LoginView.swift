//
//  LoginView.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 04/11/24.
//

import Shared
import UIKit

final class LoginView: UIView {
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 22)
        label.text = "Preencha seus dados"
        label.textColor = NexoColor.gray6
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 14)
        label.text = "Informe seu CPF ou CNPJ para acessar sua conta."
        label.textColor = NexoColor.gray3
        return label
    }()
    
    let usernameTextField: NexoTextField = {
        let textField = NexoTextField(type: .normal, title: "CPF/CNPJ")
        return textField
    }()
    
    let passwordTextField: NexoTextField = {
        let textField = NexoTextField(type: .secureText, title: "Senha")
        return textField
    }()
    
    let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Esqueci minha senha", for: .normal)
        button.setTitleColor(NexoColor.mainSecondary, for: .normal)
        button.titleLabel?.font = NexoFont.openSans(ofType: .semibold, size: 14)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    private let switchView = UIView()
    
    private let switchLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 14)
        label.text = "Salvar conta para o futuro"
        label.textColor = NexoColor.gray3
        return label
    }()
    
    let saveAccountSwitch: UISwitch = {
        let accountSwitch = UISwitch()
        accountSwitch.onTintColor = NexoColor.mainSecondary
        return accountSwitch
    }()
    
    let loginButton: NexoButton = {
        let button = NexoButton(style: .filled)
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = NexoColor.background
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension LoginView {
    
    private func setupView() {
        addSubview(welcomeLabel)
        addSubview(descriptionLabel)
        addSubview(usernameTextField)
        addSubview(passwordTextField)
        addSubview(forgotPasswordButton)
        addSubview(switchView)
        switchView.addSubview(saveAccountSwitch)
        switchView.addSubview(switchLabel)
        addSubview(loginButton)
    }
    
    private func setupConstraints() {
        welcomeLabel.anchor { make in
            make.top(to: safeAreaLayoutGuide.topAnchor, constant: 32)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: -16)
        }
        
        descriptionLabel.anchor { make in
            make.top(to: welcomeLabel.bottomAnchor, constant: 12)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        usernameTextField.anchor { make in
            make.top(to: descriptionLabel.bottomAnchor, constant: 74)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        passwordTextField.anchor { make in
            make.top(to: usernameTextField.bottomAnchor, constant: 20)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        forgotPasswordButton.anchor { make in
            make.top(to: passwordTextField.bottomAnchor, constant: 12)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        switchView.anchor { make in
            make.top(to: forgotPasswordButton.bottomAnchor, constant: 32)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        saveAccountSwitch.anchor { make in
            make.top(to: switchView.topAnchor)
            make.trailing(to: switchView.trailingAnchor)
            make.bottom(to: switchView.bottomAnchor)
        }
        
        switchLabel.anchor { make in
            make.top(to: saveAccountSwitch.topAnchor)
            make.leading(to: switchView.leadingAnchor)
            make.trailing(to: saveAccountSwitch.leadingAnchor, constant: 8)
            make.bottom(to: saveAccountSwitch.bottomAnchor)
        }
        
        loginButton.anchor { make in
            make.top(to: switchView.bottomAnchor, constant: 32, relation: .greaterThanOrEqual)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
            make.bottom(to: safeAreaLayoutGuide.bottomAnchor, constant: 16)
        }
    }
    
}
