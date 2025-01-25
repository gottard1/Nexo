//
//  BalanceCardView.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import UIKit

// ALTERAR ESSE COMPONENTE
final class BalanceCardView: UIView {
    
    private let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.shadowColor = NexoColor.black040F14.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .bold, size: 24)
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
        setupHierarchy()
        setupConstraints()
        
        setupView(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(model: BalanceCardModel) {
        valueLabel.text = String(model.value)
        iconImageView.image = UIImage(systemName: model.icon)
        
        setupColors(with: model.config.colors)
    }
    
    private func setupColors(with colors: SDUIColor?) {
        guard let textColor = colors?.textColor,
              let background = colors?.background,
              let iconColor = colors?.iconColor else { return }
        
        contentView.backgroundColor = NexoColor.loadColor(named: background)
        valueLabel.textColor = NexoColor.loadColor(named: textColor)
        iconImageView.tintColor = NexoColor.loadColor(named: iconColor)
        
    }
}

// MARK: - Layout
extension BalanceCardView {
    
    private func setupHierarchy() {
        addSubview(contentView)
        contentView.addSubview(valueLabel)
        contentView.addSubview(iconImageView)
    }
    
    private func setupConstraints() {
        contentView.anchor { make in
            make.top(to: topAnchor)
            make.leading(to: leadingAnchor)
            make.trailing(to: trailingAnchor)
            make.bottom(to: bottomAnchor, constant: 16)
            make.height(equalTo: 50)
        }
        
        valueLabel.anchor { make in
            make.top(to: contentView.topAnchor, constant: 16)
            make.leading(to: leadingAnchor, constant: 16)
            make.bottom(to: contentView.bottomAnchor, constant: 16)
        }
        
        iconImageView.anchor { make in
            make.top(to: valueLabel.topAnchor)
            make.leading(to: valueLabel.trailingAnchor, constant: 8)
            make.trailing(to: trailingAnchor, constant: 16)
            make.bottom(to: valueLabel.bottomAnchor)
        }
    }
}
