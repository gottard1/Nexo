//
//  BalanceCardView.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import UIKit

// ALTERAR ESSE COMPONENTE
class BalanceCardView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .green
        return label
    }()
    
    init(model: BalanceCardModel) {
        super.init(frame: .zero)
        setupLayout()
        
        setupView(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(model: BalanceCardModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        valueLabel.text = model.value
    }
}

// MARK: - Layout
extension BalanceCardView {
    
    private func setupLayout() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(valueLabel)
        
        addSubview(stackView)
        stackView.anchor { make in
            make.top(to: topAnchor, constant: 16)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
            make.bottom(to: bottomAnchor, constant: 16)
        }
    }
}
