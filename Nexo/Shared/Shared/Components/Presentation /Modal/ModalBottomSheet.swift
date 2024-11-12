//
//  ModalBottomSheet.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 11/11/24.
//

import UIKit

public enum ButtonType {
    case plain
    case outlined
}

public struct ButtonInformation {
    public let text: String
    public let type: ButtonType
    public let shouldDismissWhenClicked: Bool
    public let action: (() -> Void)?
    
    public init(
        text: String,
        type: ButtonType,
        shouldDismissWhenClicked: Bool = true,
        action: (() -> Void)? = nil
    ) {
        self.text = text
        self.type = type
        self.shouldDismissWhenClicked = shouldDismissWhenClicked
        self.action = action
    }
}

public final class ModalBottomSheetView: BasePresentViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.exo2Font(ofType: .bold, size: 22)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSansFont(ofType: .regular, size: 14)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let customView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.axis = .vertical
        return stackView
    }()
    
    private let userDidDismissAction: (() -> Void)?
    private let shouldDismiss: Bool
    
    public init(
        title: String,
        description: NSAttributedString,
        userDidDismissAction: (() -> Void)? = nil,
        shouldDismiss: Bool = true,
        buttons: [ButtonInformation]
    ) {
        self.userDidDismissAction = userDidDismissAction
        self.shouldDismiss = shouldDismiss
        
        super.init(nibName: nil, bundle: nil)
        
        titleLabel.text = title
        descriptionLabel.attributedText = description
        
        setupView()
        createButtons(buttons: buttons)
    }
    
    public convenience init(
        title: String,
        description: String,
        userDidDismissAction: (() -> Void)? = nil,
        shouldDismiss: Bool = true,
        buttons: [ButtonInformation],
        customView: UIImageView
    ) {
        self.init(
            title: title,
            description: description,
            userDidDismissAction: userDidDismissAction,
            shouldDismiss: shouldDismiss,
            buttons: buttons
        )
        self.customView.addSubview(customView)
    }
    
    public init(
        title: String,
        description: String,
        userDidDismissAction: (() -> Void)? = nil,
        shouldDismiss: Bool = true,
        buttons: [ButtonInformation]
    ) {
        self.userDidDismissAction = userDidDismissAction
        self.shouldDismiss = shouldDismiss
        
        super.init(nibName: nil, bundle: nil)
        
        titleLabel.text = title
        descriptionLabel.text = description
        
        setupView()
        createButtons(buttons: buttons)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func userDidDismiss() {
        guard shouldDismiss else { return }
        userDidDismissAction?()
        dismiss(animated: true)
    }
    
    private func createButtons(buttons: [ButtonInformation]) {
        for button in buttons {
            let isFilledButton = button.type == .plain
            
            let buttonStyle = isFilledButton ? ButtonStyle.filled : ButtonStyle.outlined
            
            let stackButton = NexoButton(style: buttonStyle)
            stackButton.setTitle(button.text, for: .normal)
            
            stackButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackButton.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            stackButton.onTap { [weak self] _ in
                if button.shouldDismissWhenClicked { self?.dismiss(animated: true) }
                button.action?()
            }
            
            buttonsStackView.addArrangedSubview(stackButton)
        }
    }
    
    public func addCustomView(_ view: UIView) {
        customView.addSubview(view)
    }
    
}

extension ModalBottomSheetView {
    
    private func setupView() {
        view.backgroundColor = NexoColor.background
        modalPresentationStyle = .custom
        transitioningDelegate = self
        buildHierarchy()
        setupConstraints()
    }
    
    private func buildHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(customView)
        view.addSubview(buttonsStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            customView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            buttonsStackView.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: 16),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonsStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -16)
        ])
    }
}

public extension ModalBottomSheetView {
    func present() {
        if let currentViewController = UIApplication.currentViewController() {
            currentViewController.present(self, animated: true)
        }
    }
}
