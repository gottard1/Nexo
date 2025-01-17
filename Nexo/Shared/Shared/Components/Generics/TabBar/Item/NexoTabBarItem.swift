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
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let selectionIndicator: UIView = {
        let view = UIView()
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
        
        selectionIndicator.anchor { make in
            make.top(to: topAnchor)
            make.centerX(to: centerXAnchor)
            make.width(equalTo: 70)
            make.height(equalTo: 4)
        }
        
        imageView.anchor { make in
            make.centerX(to: centerXAnchor)
            make.top(to: selectionIndicator.bottomAnchor, constant: 4)
            make.width(equalTo: 24)
            make.height(equalTo: 24)
        }
        
        titleLabel.anchor { make in
            make.top(to: imageView.bottomAnchor, constant: 4)
            make.leading(to: leadingAnchor)
            make.trailing(to: trailingAnchor)
        }
        
        selectionIndicator.isHidden = true
    }
    
}
