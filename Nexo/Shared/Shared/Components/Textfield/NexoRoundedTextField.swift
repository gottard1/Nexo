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
        label.font = NexoFont.openSans(ofType: .regular, size: 16)
        label.textColor = NexoColor.gray6
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = NexoColor.background
        textField.layer.cornerRadius = 16
        textField.textColor = NexoColor.gray4
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
        
        titleLabel.anchor { make in
            make.top(to: topAnchor)
            make.leading(to: leadingAnchor)
            make.trailing(to: trailingAnchor)
        }
        
        textField.anchor { make in
            make.top(to: titleLabel.bottomAnchor, constant: 8)
            make.leading(to: leadingAnchor)
            make.trailing(to: trailingAnchor)
            make.height(equalTo: 50)
            make.bottom(to: bottomAnchor)
        }
    }
}
