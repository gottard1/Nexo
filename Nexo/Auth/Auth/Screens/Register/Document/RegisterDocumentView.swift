//
//  RegisterDocumentView.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 05/12/24.
//

import Shared
import UIKit

final class RegisterDocumentView: UIView {
    
    let progressView: ProgressBarView = {
        let progressView = ProgressBarView(totalSteps: 4)
        progressView.currentStep = 1
        return progressView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 22)
        label.text = "Começando com o pé direito"
        label.textColor = NexoColor.gray6
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 14)
        label.text = "Deve ser inserido um documento válido para iniciar a criação da sua conta"
        label.textColor = NexoColor.gray3
        return label
    }()
    
    let usernameTextField: NexoTextField = {
        let textField = NexoTextField(type: .normal, title: "Documento")
        textField.type = .document
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
extension RegisterDocumentView {
    
    private func setupView() {
        addSubview(progressView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(usernameTextField)
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
        
        usernameTextField.anchor { make in
            make.top(to: descriptionLabel.bottomAnchor, constant: 32)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        continueButton.anchor { make in
            make.top(to: usernameTextField.bottomAnchor, constant: 32, relation: .greaterThanOrEqual)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
            make.bottom(to: safeAreaLayoutGuide.bottomAnchor, constant: 16)
        }
    }
    
}
