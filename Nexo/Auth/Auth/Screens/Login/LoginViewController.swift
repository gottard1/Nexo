//
//  LoginViewController.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 24/09/24.
//

import UIKit
import Shared

final class LoginViewController: UIViewController {
    
    weak var coordinator: Coordinator?
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private let enabled: NexoButton = {
        let button = NexoButton(style: .filled)
        button.setTitle("Habilitado", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let enabledAndDisable: NexoButton = {
        let button = NexoButton(style: .filled)
        button.setTitle("Habilitado e desabilitado", for: .normal)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let destructive: NexoButton = {
        let button = NexoButton(style: .destructive)
        button.setTitle("Destrutivo", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let text: NexoButton = {
        let button = NexoButton(style: .onlyText)
        button.setTitle("Texto", for: .normal)
        button.enableTitleColor = NexoColor.mainSecondary
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupActions()
    }
    
    private func setupView() {
        view.backgroundColor = NexoColor.whiteF2F2F2
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(enabled)
        stackView.addArrangedSubview(destructive)
        stackView.addArrangedSubview(enabledAndDisable)
        stackView.addArrangedSubview(text)
    }
    
    private func setupActions() {
        enabled.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        enabledAndDisable.isEnabled.toggle()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
