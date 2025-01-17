//
//  ButtonGrid.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import UIKit

// ALTERAR ESSE COMPONENTE
final class CustomButton: UIView {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private var actionHandler: (() -> Void)?
    
    init(model: CustomMenuButtonModel) {
        super.init(frame: .zero)
        setupUI()
        configure(with: model)
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
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
        addGestureRecognizer(tapGesture)
    }
    
    func configure(with model: CustomMenuButtonModel) {
        imageView.image = UIImage(named: model.icon)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        titleLabel.text = model.title
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .black
        
        actionHandler = {
            print("Custom Button Action: \(model.action)")
        }
    }
    
    @objc private func didTapButton() {
        actionHandler?()
    }
}
