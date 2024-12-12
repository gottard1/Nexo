//
//  RegisterInitialView.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 02/12/24.
//

import Shared
import UIKit

final class RegisterInitialView: UIView {
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = NexoColor.mainSecondary
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 34)
        label.text = "Siga o passo a passo e abra sua conta "
        label.numberOfLines = 0
        label.textColor = NexoColor.mainSecondary
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = NexoImage.registerInitial
        return imageView
    }()
    
    let nextButton: NexoButton = {
        let button = NexoButton(style: .filled)
        button.setTitle("Iniciar cadastro", for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        backgroundColor = NexoColor.black040F14
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(backButton)
        addSubview(nextButton)
        
        imageView.anchor { make in
            make.top(to: topAnchor)
            make.leading(to: leadingAnchor)
            make.trailing(to: trailingAnchor)
            make.bottom(to: bottomAnchor)
        }
        
        backButton.anchor { make in
            make.top(to: safeAreaLayoutGuide.topAnchor, constant: 10)
            make.leading(to: leadingAnchor, constant: 20)
        }
        
        titleLabel.anchor { make in
            make.top(to: backButton.bottomAnchor, constant: 20)
            make.leading(to: leadingAnchor, constant: 20)
            make.trailing(to: trailingAnchor, constant: 20)
        }
        
        nextButton.anchor { make in
            make.leading(to: leadingAnchor, constant: 20)
            make.trailing(to: trailingAnchor, constant: 20)
            make.bottom(to: safeAreaLayoutGuide.bottomAnchor, constant: 12)
        }
    }
}
