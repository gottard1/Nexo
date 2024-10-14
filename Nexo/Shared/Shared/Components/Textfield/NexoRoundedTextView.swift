//
//  NexoRoundedTextView.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 11/10/24.
//

import UIKit

public final class NexoRoundedTextView: UIView, UITextViewDelegate {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = NexoColor.gray6
        label.font = NexoFont.openSansFont(ofType: .regular, size: 16)
        return label
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = NexoColor.background
        textView.font = NexoFont.openSansFont(ofType: .regular, size: 14)
        textView.layer.cornerRadius = 8
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = NexoColor.gray5
        label.font = NexoFont.openSansFont(ofType: .regular, size: 14)
        return label
    }()
    
    public init(title: String, placeholder: String?, hint: String?) {
        super.init(frame: .zero)
        setupView()
        
        titleLabel.text = title
        
        if let placeholder {
            textView.text = placeholder
            textView.textColor = NexoColor.gray2
        }
        
        if let hint {
            hintLabel.text = hint
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(textView)
        addSubview(hintLabel)
        
        textView.delegate = self
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 100),
            
            hintLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8),
            hintLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            hintLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
        textView.textColor = NexoColor.gray6
    }
}
