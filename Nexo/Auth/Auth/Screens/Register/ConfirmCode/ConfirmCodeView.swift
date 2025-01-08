//
//  ConfirmCodeView.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 13/12/24.
//

import UIKit
import Shared

final class ConfirmCodeView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 22)
        label.text = "Um novo código foi enviado para o seu e-mail"
        label.numberOfLines = 0
        label.textColor = NexoColor.gray6
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 14)
        label.text = "Não recebeu? \nAguarde o timer e clique no botão."
        label.numberOfLines = 0
        label.textColor = NexoColor.gray3
        return label
    }()
    
    let codeTextInput = CodeInputField()
    
    let reSendButton: NexoButton = {
        let button = NexoButton(style: .filled)
        button.isEnabled = false
        button.setTitle("Enviar novo código", for: .normal)
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
extension ConfirmCodeView {
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(codeTextInput)
        addSubview(descriptionLabel)
        addSubview(reSendButton)
    }
    
    private func setupConstraints() {
        titleLabel.anchor { make in
            make.top(to: safeAreaLayoutGuide.topAnchor, constant: 16)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        codeTextInput.anchor { make in
            make.centerY(to: centerYAnchor, constant: -80)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        descriptionLabel.anchor { make in
            make.top(to: codeTextInput.bottomAnchor, constant: 16)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
        }
        
        reSendButton.anchor { make in
            make.top(to: codeTextInput.bottomAnchor, constant: 32, relation: .greaterThanOrEqual)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
            make.bottom(to: safeAreaLayoutGuide.bottomAnchor, constant: 16)
        }
    }
    
}

