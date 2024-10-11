//
//  NexoTabBarItem.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 08/10/24.
//

import UIKit

class NexoTabBarItem: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let selectionIndicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.backgroundColor = NexoColor.mainSecondary
        return view
    }()
    
    var isSelected: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    init(model: NexoTabBarItemModel) {
        super.init(frame: .zero)
        
        setupView()
        configureView(model: model)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView(model: NexoTabBarItemModel) {
        titleLabel.text = model.title
        imageView.image = model.image.withRenderingMode(.alwaysTemplate)
    }
    
    private func updateAppearance() {
        selectionIndicator.isHidden = !isSelected
        imageView.tintColor = isSelected ? NexoColor.mainSecondary : NexoColor.gray3
        titleLabel.textColor = isSelected ? NexoColor.mainSecondary : NexoColor.gray3
    }
}

// MARK: - Layout
extension NexoTabBarItem {
    
    private func setupView() {
        addSubview(selectionIndicator)
        addSubview(imageView)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            selectionIndicator.topAnchor.constraint(equalTo: topAnchor),
            selectionIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            selectionIndicator.widthAnchor.constraint(equalToConstant: 70),
            selectionIndicator.heightAnchor.constraint(equalToConstant: 4),
            
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: selectionIndicator.bottomAnchor, constant: 4),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        selectionIndicator.isHidden = true
    }
    
}
