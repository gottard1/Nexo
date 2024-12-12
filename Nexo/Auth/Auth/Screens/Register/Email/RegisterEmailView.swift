//
//  RegisterEmailView.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 09/12/24.
//

import Shared
import UIKit

final class RegisterEmailView: UIView {
    
    let progressView: ProgressBarView = {
        let progressView = ProgressBarView(totalSteps: 4)
        progressView.currentStep = 2
        return progressView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 22)
        label.text = "Chegamos na metade"
        label.textColor = NexoColor.gray6
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 14)
        label.text = "Escolha o e-mail para vincular a sua conta"
        label.textColor = NexoColor.gray3
        return label
    }()
    
    let emailTextField: NexoTextField = {
        let textField = NexoTextField(type: .normal, title: "E-mail")
        textField.placeholder = "nelson@nexo.com.br"
        return textField
    }()
    
    let confirmEmailTextField: NexoTextField = {
        let textField = NexoTextField(type: .normal, title: "Confirmação seu e-mail")
        textField.placeholder = "nelson@nexo.com.br"
        return textField
    }()
    
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
extension RegisterEmailView {
    
    private func setupView() {
        addSubview(progressView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(emailTextField)
        addSubview(confirmEmailTextField)
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
        
        emailTextField.anchor { make in
            make.top(to: descriptionLabel.bottomAnchor, constant: 32)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        confirmEmailTextField.anchor { make in
            make.top(to: emailTextField.bottomAnchor, constant: 20)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        continueButton.anchor { make in
            make.top(to: confirmEmailTextField.bottomAnchor, constant: 32, relation: .greaterThanOrEqual)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
            make.bottom(to: safeAreaLayoutGuide.bottomAnchor, constant: 16)
        }
    }
    
}
