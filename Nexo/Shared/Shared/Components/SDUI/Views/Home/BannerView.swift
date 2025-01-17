//
//  BannerView.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import UIKit

// ALTERAR ESSE COMPONENTE
class BannerView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView(with model: BannerModel) {
//        imageView.image.loadImage(from: model.icon)
    }
}

// MARK: - Layout
extension BannerView {
    
    private func setupLayout() {
        addSubview(imageView)
        
        imageView.anchor { make in
            make.top(to: topAnchor)
            make.leading(to: leadingAnchor)
            make.trailing(to: trailingAnchor)
            make.bottom(to: bottomAnchor)
        }
    }
}
