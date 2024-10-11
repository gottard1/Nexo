//
//  NexoTextField.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 11/10/24.
//

import UIKit

public enum NexoTextFieldType {
    case normal
    case withHelper(String) // Helper text abaixo do campo
    case withIcon(UIImage)  // Ícone à direita
    case actionButton(String)  // Texto à direita como botão
    case currency(UIImage)  // Ícone de moeda à esquerda
    case secureText(UIImage)  // Campo de senha com ícone de visibilidade
}

public final class NexoTextField: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Placeholder"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .darkText
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let helperLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Action", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public init(type: NexoTextFieldType) {
        super.init(frame: .zero)
        setupView()
        configure(for: type)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(helperLabel)
        addSubview(iconImageView)
        addSubview(actionButton)
        addSubview(bottomLineView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),  // Placeholder para ícone ou botão
            
            helperLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            helperLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            helperLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            helperLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            iconImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            actionButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            
            bottomLineView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            bottomLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    public func configure(for type: NexoTextFieldType) {
        switch type {
            case .normal:
                break  // Sem modificações
            case .withHelper(let helperText):
                helperLabel.text = helperText
                helperLabel.isHidden = false
            case .withIcon(let icon):
                iconImageView.image = icon
                iconImageView.isHidden = false
            case .actionButton(let buttonText):
                actionButton.setTitle(buttonText, for: .normal)
                actionButton.isHidden = false
            case .currency(let icon):
                textField.leftView = UIImageView(image: icon)
                textField.leftViewMode = .always
            case .secureText(let icon):
                textField.isSecureTextEntry = true
                iconImageView.image = icon
                iconImageView.isHidden = false
        }
    }
    
    public func updateTitle(_ title: String) {
        titleLabel.text = title
    }
    
    public func updatePlaceholder(_ placeholder: String) {
        textField.placeholder = placeholder
    }
    
    public func updateHelper(_ helperText: String) {
        helperLabel.text = helperText
        helperLabel.isHidden = false
    }
}
