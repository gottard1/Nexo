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
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
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
        valueLabel.text = model.value
        iconImageView.image = UIImage(systemName: model.icon)
    }
}

// MARK: - Layout
extension BalanceCardView {
    
    private func setupLayout() {
        stackView.addArrangedSubview(valueLabel)
        stackView.addArrangedSubview(iconImageView)
        
        addSubview(stackView)
        stackView.anchor { make in
            make.top(to: topAnchor, constant: 16)
            make.leading(to: leadingAnchor, constant: 16)
            make.trailing(to: trailingAnchor, constant: 16)
            make.bottom(to: bottomAnchor, constant: 16)
        }
    }
}
