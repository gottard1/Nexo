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
        label.font = NexoFont.exo2(ofType: .bold, size: 22)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 14)
        label.textAlignment = .justified
        label.numberOfLines = 0
        return label
    }()
    
    private let customView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
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
            
            stackButton.anchor { make in
                make.height(equalTo: 50)
            }
            
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
        titleLabel.anchor { make in
            make.top(to: view.topAnchor, constant: 20)
            make.leading(to: view.leadingAnchor, constant: 16)
            make.trailing(to: view.trailingAnchor, constant: 16)
        }
        
        descriptionLabel.anchor { make in
            make.top(to: titleLabel.bottomAnchor, constant: 16)
            make.leading(to: view.leadingAnchor, constant: 16)
            make.trailing(to: view.trailingAnchor, constant: 16)
        }
        
        customView.anchor { make in
            make.top(to: descriptionLabel.bottomAnchor, constant: 16)
            make.leading(to: view.leadingAnchor, constant: 16)
            make.trailing(to: view.trailingAnchor, constant: 16)
        }
        
        buttonsStackView.anchor { make in
            make.top(to: customView.bottomAnchor, constant: 16)
            make.leading(to: view.leadingAnchor, constant: 16)
            make.trailing(to: view.trailingAnchor, constant: 16)
            make.bottom(to: view.bottomAnchor, constant: 16)
        }
    }
}

public extension ModalBottomSheetView {
    func present() {
        if let currentViewController = UIApplication.currentViewController() {
            currentViewController.present(self, animated: true)
        }
    }
}
