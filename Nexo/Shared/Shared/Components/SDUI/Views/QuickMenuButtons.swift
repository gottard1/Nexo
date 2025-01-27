//
//  QuickMenuButtons.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 17/01/25.
//

import UIKit

final class QuickMenuButton: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 14)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    var actionHandler: (() -> Void)?
    
    // MARK: - Initializer
    init(model: ServiceMenuButtonModel) {
        super.init(frame: .zero)
        setupUI()
        configure(with: model)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: ServiceMenuButtonModel) {
        imageView.image = UIImage(systemName: model.icon)
        
        imageView.tintColor = model.config?.colors?.iconColor?.loadColor
        
        titleLabel.text = model.title
        titleLabel.textColor = model.config?.colors?.textColor?.loadColor
        
        backgroundColor = model.config?.colors?.background?.loadColor
        
        actionHandler = {
            print("Service Button Action: \(model.action)")
        }
    }
}

// MARK: - Helpers & action
extension QuickMenuButton {
    
    @objc private func didTapButton() {
        actionHandler?()
    }
    
}

// MARK: - Layout
extension QuickMenuButton {
    
    private func setupUI() {
        layer.cornerRadius = 8
        clipsToBounds = true
        
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.anchor { make in
            make.top(to: topAnchor, constant: 16)
            make.centerX(to: centerXAnchor)
            make.height(equalTo: 24)
            make.width(equalTo: 24)
        }
        
        titleLabel.anchor { make in
            make.top(to: imageView.bottomAnchor, constant: 8)
            make.leading(to: leadingAnchor, constant: 8)
            make.trailing(to: trailingAnchor, constant: 8)
            make.bottom(to: bottomAnchor, constant: 16)
        }
    }
    
    
}
