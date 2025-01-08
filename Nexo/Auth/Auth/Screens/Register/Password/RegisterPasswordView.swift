//
//  RegisterPasswordView.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 19/12/24.
//

import UIKit
import Shared

final class RegisterPasswordView: UIView {
    let progressView: ProgressBarView = {
        let progressView = ProgressBarView(totalSteps: 4)
        progressView.currentStep = 4
        return progressView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 22)
        label.text = "Ultimo passo! Antes da felicidade"
        label.textColor = NexoColor.gray6
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 14)
        label.text = "Escolha uma senha FORTE igual você!"
        label.textColor = NexoColor.gray3
        return label
    }()
    
    private let especialCharacterLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 14)
        label.text = "Tem ao menos caractere especial"
        label.textColor = NexoColor.gray3
        return label
    }()
    
    private let someNumberLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 14)
        label.text = "Tem ao menos algum número"
        label.textColor = NexoColor.gray3
        return label
    }()
    
    private let someLetterLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 14)
        label.text = "Tem ao menos uma letra maiúscula"
        label.textColor = NexoColor.gray3
        return label
    }()
    
    let passwordTextField = NexoTextField(type: .secureText, title: "Senha")
    
    let confirmPasswordTextField = NexoTextField(type: .secureText, title: "Confirme a senha")
    
    let continueButton: NexoButton = {
        let button = NexoButton(style: .filled)
        button.isEnabled = false
        button.setTitle("continuar", for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = NexoColor.background
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension RegisterPasswordView {
    
    private func setupView() {
        addSubview(progressView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(passwordTextField)
        addSubview(confirmPasswordTextField)
        addSubview(especialCharacterLabel)
        addSubview(someNumberLabel)
        addSubview(someLetterLabel)
        addSubview(continueButton)
    }
    
    private func setupConstraints() {
        progressView.anchor { make in
            make.top(to: safeAreaLayoutGuide.topAnchor)
            make.leading(to: leadingAnchor)
            make.trailing(to: trailingAnchor)
            make.height(equalTo: 20)
        }
        
        titleLabel.anchor { make in
            make.top(to: progressView.bottomAnchor, constant: 16)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        descriptionLabel.anchor { make in
            make.top(to: titleLabel.bottomAnchor, constant: 8)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        passwordTextField.anchor { make in
            make.top(to: descriptionLabel.bottomAnchor, constant: 32)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        confirmPasswordTextField.anchor { make in
            make.top(to: passwordTextField.bottomAnchor, constant: 20)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        especialCharacterLabel.anchor { make in
            make.top(to: confirmPasswordTextField.bottomAnchor, constant: 12)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        someNumberLabel.anchor { make in
            make.top(to: especialCharacterLabel.bottomAnchor, constant: 4)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        someLetterLabel.anchor { make in
            make.top(to: someNumberLabel.bottomAnchor, constant: 4)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        continueButton.anchor { make in
            make.top(to: someLetterLabel.bottomAnchor, constant: 32, relation: .greaterThanOrEqual)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
            make.bottom(to: safeAreaLayoutGuide.bottomAnchor, constant: 16)
        }
    }
    
}
