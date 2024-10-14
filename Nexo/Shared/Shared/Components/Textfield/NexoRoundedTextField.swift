//
//  NexoRoundedTextField.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 11/10/24.
//

import UIKit

public final class NexoRoundedTextField: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = NexoFont.openSansFont(ofType: .regular, size: 16)
        label.textColor = NexoColor.gray6
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = NexoColor.gray4
        textField.layer.cornerRadius = 16
        textField.textColor = NexoColor.gray2
        return textField
    }()
    
    public init(title: String?, placeholder: String?) {
        super.init(frame: .zero)
        setupView()
        setupLeftView()
        
        if let title {
            titleLabel.text = title
        }
        
        if let placeholder {
            textField.placeholder = placeholder
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupLeftView() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: self.frame.size.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
