//
//  ServiceButton.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 17/01/25.
//

import UIKit

// ALTERAR ESSE COMPONENTE
final class ServiceButton: UIView {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private var actionHandler: (() -> Void)?
    
    init(model: ServiceMenuButtonModel) {
        super.init(frame: .zero)
        setupUI()
        configure(with: model)
        
        let background = model.config.colors?.background
        let color = NexoColor.color(named: background)
        backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        stackView.anchor { make in
            make.top(to: topAnchor)
            make.leading(to: leadingAnchor)
            make.trailing(to: trailingAnchor)
            make.bottom(to: bottomAnchor)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
        addGestureRecognizer(tapGesture)
    }
    
    func configure(with model: ServiceMenuButtonModel) {
        imageView.image = UIImage(systemName: model.icon)
        imageView.contentMode = .scaleAspectFit
        
        let iconColor = model.config.colors?.iconColor
        let tintColor = NexoColor.color(named: iconColor)
        imageView.tintColor = tintColor
        
        imageView.anchor { make in
            make.width(equalTo: 24)
            make.height(equalTo: 24)
        }
        
        titleLabel.text = model.title
        titleLabel.font = .systemFont(ofSize: 14)
        
        let color = model.config.colors?.textColor
        let textColor = NexoColor.color(named: color)
        titleLabel.textColor = textColor
        
        actionHandler = {
            print("Service Button Action: \(model.action)")
        }
    }
    
    @objc private func didTapButton() {
        actionHandler?()
    }
}
