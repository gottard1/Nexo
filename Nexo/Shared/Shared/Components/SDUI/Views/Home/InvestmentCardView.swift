//
//  InvestmentCardView.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 17/01/25.
//

import UIKit

// ALTERAR ESSE COMPONENTE
final class InvestmentCardView: UIView {
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let actionButton = UIButton(type: .system)
    
    private var actionHandler: (() -> Void)?
    
    init(model: InvestmentCardButtonModel) {
        super.init(frame: .zero)
        setupUI()
        configure(with: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, actionButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        actionButton.setTitle("Investir", for: .normal)
        actionButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    func configure(with model: InvestmentCardButtonModel) {
        titleLabel.text = model.title
        titleLabel.font = .boldSystemFont(ofSize: 16)
        
        descriptionLabel.text = model.description
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .gray
        
        actionHandler = {
            print("Investment action: \(model.action)")
        }
        
        actionButton.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
    }
    
    @objc private func didTapAction() {
        actionHandler?()
    }
}
