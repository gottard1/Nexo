//
//  OnboardingView.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 19/11/24.
//

import UIKit
import Shared

protocol OnboardingViewProtocol: AnyObject {
    func navigateTo(action: AuthActions)
}

final class OnboardingView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = NexoImage.onboarding
        return imageView
    }()
    
    private let buttonsView: UIView = {
        let view = GradientView(gradientColors: [
            .clear,
            NexoColor.mainPrimary
        ])
        return view
    }()
    
    let registerButton: NexoButton = {
        let button = NexoButton(style: .filled)
        button.setTitle("Abra uma conta", for: .normal)
        return button
    }()
    
    let loginButton: NexoButton = {
        let button = NexoButton(style: .outlined)
        button.setTitle("Acessar minha conta", for: .normal)
        return button
    }()
    
    let accountButton: NexoButton = {
        let button = NexoButton(style: .onlyText)
        button.setTitle("Acompanhar abertura", for: .normal)
        button.enableTitleColor = NexoColor.mainSecondary
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
        addSubview(buttonsView)
        
        buttonsView.addSubview(registerButton)
        buttonsView.addSubview(loginButton)
        buttonsView.addSubview(accountButton)
        
        imageView.anchor { make in
            make.top(to: topAnchor)
            make.leading(to: leadingAnchor)
            make.trailing(to: trailingAnchor)
            make.bottom(to: bottomAnchor)
        }
        
        buttonsView.anchor { make in
            make.leading(to: leadingAnchor)
            make.trailing(to: trailingAnchor)
            make.bottom(to: bottomAnchor)
        }
        
        registerButton.anchor { make in
            make.top(to: buttonsView.topAnchor, constant: 100)
            make.leading(to: buttonsView.leadingAnchor, constant: 20)
            make.trailing(to: buttonsView.trailingAnchor, constant: 20)
        }
        
        loginButton.anchor { make in
            make.top(to: registerButton.bottomAnchor, constant: 20)
            make.leading(to: buttonsView.leadingAnchor, constant: 20)
            make.trailing(to: buttonsView.trailingAnchor, constant: 20)
        }
        
        accountButton.anchor { make in
            make.top(to: loginButton.bottomAnchor, constant: 8)
            make.leading(to: buttonsView.leadingAnchor, constant: 20)
            make.trailing(to: buttonsView.trailingAnchor, constant: 20)
            make.bottom(to: safeAreaLayoutGuide.bottomAnchor, constant: 12)
        }
    }
}
