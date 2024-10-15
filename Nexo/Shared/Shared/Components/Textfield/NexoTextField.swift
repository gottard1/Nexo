//
//  NexoTextField.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 11/10/24.
//

import UIKit

public enum NexoTextFieldType {
    case normal
    case withHelper(String)
    case withIcon(UIImage)
    case actionButton(String)
    case currency(UIImage?)
    case secureText
}

public final class NexoTextField: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = NexoColor.gray6
        label.font = NexoFont.openSansFont(ofType: .regular, size: 16)
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = NexoFont.openSansFont(ofType: .regular, size: 16)
        textField.textColor = NexoColor.black040F14
        return textField
    }()
    
    private let helperLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = NexoColor.gray3
        label.font = NexoFont.openSansFont(ofType: .regular, size: 12)
        label.isHidden = true
        return label
    }()
    
    // Substituímos o UIImageView por um UIButton
    private let iconButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = NexoColor.mainSecondary
        button.isHidden = true
        return button
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Action", for: .normal)
        button.titleLabel?.font = NexoFont.openSansFont(ofType: .regular, size: 16)
        button.titleLabel?.textColor = NexoColor.mainSecondary
        button.tintColor = NexoColor.mainSecondary
        button.isHidden = true
        return button
    }()
    
    private let bottomLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = NexoColor.gray2
        return view
    }()
    
    public var activeColor: UIColor = NexoColor.mainSecondary
    public var inactiveColor: UIColor = NexoColor.gray2
    public var type: NexoTextFieldType = .normal
    
    private var isPasswordVisible = false // Controla a visibilidade da senha
    
    public init(
        type: NexoTextFieldType,
        title: String,
        placeholder: String? = nil
    ) {
        self.type = type
        super.init(frame: .zero)
        setupView()
        
        titleLabel.text = title
        
        if let placeholder {
            textField.placeholder = placeholder
        }
        
        configure(for: type)
        
        textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(helperLabel)
        addSubview(iconButton)
        addSubview(actionButton)
        addSubview(bottomLineView)
        
        setupConstraints()
    }
    
    public func configure(for type: NexoTextFieldType) {
        switch type {
            case .normal:
                break
            case .withHelper(let helperText):
                helperLabel.text = helperText
                helperLabel.isHidden = false
            case .withIcon(let icon):
                iconButton.setImage(icon, for: .normal)
                iconButton.isHidden = false
                iconButton.addTarget(self, action: #selector(iconButtonTapped), for: .touchUpInside)
            case .actionButton(let buttonText):
                actionButton.setTitle(buttonText, for: .normal)
                actionButton.isHidden = false
            case .currency(let rightIcon):
                let currencyLabel = UILabel()
                currencyLabel.text = "R$"
                currencyLabel.font = NexoFont.exo2Font(ofType: .bold, size: 22)
                currencyLabel.textColor =  NexoColor.black040F14
                currencyLabel.textAlignment = .center
                currencyLabel.frame = CGRect(x: 0, y: 0, width: 32, height: 36)
                
                let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
                leftView.addSubview(currencyLabel)
                
                textField.font = NexoFont.exo2Font(ofType: .bold, size: 22)
                
                textField.placeholder = "0,00"
                textField.leftView = leftView
                textField.leftViewMode = .always
                textField.keyboardType = .decimalPad
                
                if let rightIcon {
                    iconButton.setImage(rightIcon, for: .normal)
                    iconButton.isHidden = false
                    iconButton.addTarget(self, action: #selector(iconButtonTapped), for: .touchUpInside)
                }
            case .secureText:
                textField.isSecureTextEntry = true
                iconButton.isHidden = false
                iconButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
                iconButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        }
    }
    
    @objc private func iconButtonTapped() {
        print("Icon tapped")
    }
    
    @objc private func togglePasswordVisibility() {
        isPasswordVisible.toggle()
        textField.isSecureTextEntry = !isPasswordVisible
        let iconImage = isPasswordVisible ? UIImage(systemName: "eye.fill") : UIImage(systemName: "eye.slash.fill")
        iconButton.setImage(iconImage, for: .normal)
    }
}

// MARK: - UITextField Delegate
extension NexoTextField: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        bottomLineView.backgroundColor = activeColor
        titleLabel.textColor = activeColor
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        bottomLineView.backgroundColor = inactiveColor
        titleLabel.textColor = inactiveColor
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if case .currency = type {
            guard let currentText = textField.text as NSString? else { return true }
            let newString = currentText.replacingCharacters(in: range, with: string)
            
            let digits = newString.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            
            if let value = Double(digits) {
                let formatter = NumberFormatter()
                formatter.numberStyle = .currency
                formatter.currencySymbol = ""
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
                
                let formattedValue = formatter.string(from: NSNumber(value: value / 100))
                textField.text = formattedValue
            } else {
                textField.text = ""
            }
            return false
        }
        return true
    }
}

// MARK: - Layout
extension NexoTextField {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            helperLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            helperLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            helperLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            helperLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            iconButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            iconButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            iconButton.widthAnchor.constraint(equalToConstant: 32),
            iconButton.heightAnchor.constraint(equalToConstant: 32),
            
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            actionButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            
            bottomLineView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            bottomLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
