//
//  NexoRoundedTextView.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 11/10/24.
//

import UIKit

public final class NexoRoundedTextView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        textView.layer.cornerRadius = 8
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.text = "Hint"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(textView)
        addSubview(hintLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 100),
            
            hintLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -8),
            hintLabel.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: -8),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configure(withTitle title: String, placeholder: String, hint: String) {
        titleLabel.text = title
        textView.text = placeholder
        hintLabel.text = hint
    }
}
