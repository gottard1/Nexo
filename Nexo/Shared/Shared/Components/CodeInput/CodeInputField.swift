//
//  CodeInputField.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 13/12/24.
//

import UIKit

public protocol CodeInputFieldDelegate: AnyObject {
    func didEnterCode(_ code: String)
}

public class CodeInputField: UIView {
    private var otp: String = ""
    private var textFields: [UITextField] = []
    private let numberOfFields: Int = 6
    
    public weak var delegate: CodeInputFieldDelegate?
    
    public init() {
        super.init(frame: .zero)
        setupStackView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Functions
private extension CodeInputField {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if text.count > 1 {
            textField.text = String(text.prefix(1))
        }
        
        if text.isEmpty {
            moveFocus(to: textField.tag - 1)
        } else {
            moveFocus(to: textField.tag + 1)
        }
        
        updateOTPString()
    }
    
    func moveFocus(to index: Int) {
        guard index >= 0, index < textFields.count else { return }
        textFields[index].becomeFirstResponder()
    }
}

// MARK: - Helpers
private extension CodeInputField {
    func updateOTPString() {
        otp = textFields.compactMap { $0.text }.joined()
        if otp.count == numberOfFields {
            delegate?.didEnterCode(otp)
            textFields.last?.resignFirstResponder()
        }
    }
}

// MARK: - TextField Delegate
extension CodeInputField: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

// MARK: - Layout
private extension CodeInputField {
    func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.anchor { make in
            make.top(to: topAnchor)
            make.leading(to: leadingAnchor, constant: 8)
            make.trailing(to: trailingAnchor, constant: 8)
            make.bottom(to: bottomAnchor)
        }
        
        for index in 0..<numberOfFields {
            let textField = createCustomTextField(tag: index)
            stackView.addArrangedSubview(textField)
            textFields.append(textField)
        }
    }
    
    func createCustomTextField(tag: Int) -> UITextField {
        let textField = UITextField()
        textField.tag = tag
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.font = NexoFont.exo2(ofType: .bold, size: 22)
        textField.textColor = NexoColor.mainSecondary
        textField.tintColor = NexoColor.mainSecondary
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.borderStyle = .none
        
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = NexoColor.mainSecondary
        textField.addSubview(bottomBorder)
        
        bottomBorder.anchor { make in
            make.leading(to: textField.leadingAnchor)
            make.trailing(to: textField.trailingAnchor)
            make.bottom(to: textField.bottomAnchor)
            make.height(equalTo: 2)
        }
        
        textField.anchor { make in
            make.height(equalTo: 60)
        }
        
        return textField
    }
}
