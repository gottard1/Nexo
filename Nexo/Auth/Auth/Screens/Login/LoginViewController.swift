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
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
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
    
    private let normalTextField = NexoTextField(type: .normal, title: "Normal")
    private let helperTextField = NexoTextField(type: .withHelper("Helper* se precisar"), title: "Com Dica")
    private let iconTextField = NexoTextField(type: .withIcon(UIImage(systemName: "trash.square.fill") ?? UIImage()), title: "Com imagem")
    private let actionButtonTextField = NexoTextField(type: .actionButton("Action"), title: "Com botão de ação")
    private let currencyTextField = NexoTextField(type: .currency(UIImage(systemName: "trash.square.fill") ?? UIImage()), title: "Dinheiro")
    private let secureTextField = NexoTextField(type: .secureText(UIImage(systemName: "arrowshape.left.fill") ?? UIImage()), title: "Senha")
    private let roundedTextField = NexoRoundedTextField(title: "TextField", placeholder: "Placeholder")
    private let roundedTextView = NexoRoundedTextView(title: "TextView", placeholder: "Escreva qualquer coisa", hint: "Dica")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupActions()
    }
    
    private func setupView() {
        view.backgroundColor = NexoColor.whiteF2F2F2
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(enabled)
        stackView.addArrangedSubview(destructive)
        stackView.addArrangedSubview(enabledAndDisable)
        stackView.addArrangedSubview(text)
        stackView.addArrangedSubview(normalTextField)
        stackView.addArrangedSubview(helperTextField)
        stackView.addArrangedSubview(iconTextField)
        stackView.addArrangedSubview(actionButtonTextField)
        stackView.addArrangedSubview(currencyTextField)
        stackView.addArrangedSubview(secureTextField)
        stackView.addArrangedSubview(roundedTextView)
        stackView.addArrangedSubview(roundedTextField)
    }
    
    private func setupActions() {
        enabled.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        enabledAndDisable.isEnabled.toggle()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}
