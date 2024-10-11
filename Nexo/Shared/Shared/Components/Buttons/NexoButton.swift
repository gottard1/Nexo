//
//  NexoButton.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 23/09/24.
//

import UIKit

public enum ButtonStyle {
    case filled
    case outlined
    case onlyText
    case destructive
    case disabled
}

public final class NexoButton: UIButton {
    
    private var buttonStyle: ButtonStyle = .filled
    
    public var enableBackgroundColor: UIColor = NexoColor.mainSecondary {
        didSet {
            setupButton()
        }
    }
    
    public var borderColor: UIColor = NexoColor.mainSecondary {
        didSet {
            setupButton()
        }
    }
    
    public var enableTitleColor: UIColor = .white {
        didSet {
            setupButton()
        }
    }
    
    public var disableTitleColor: UIColor = .white {
        didSet {
            setupButton()
        }
    }
    
    public var disableBackgroundColor: UIColor = NexoColor.disable {
        didSet {
            setupButton()
        }
    }
    
    public init(style: ButtonStyle = .filled) {
        super.init(frame: .zero)
        self.buttonStyle = style
        setupButton()
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    public override var isEnabled: Bool {
        didSet {
            setupButton()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        switch buttonStyle {
            case .filled:
                backgroundColor = isEnabled ? enableBackgroundColor : disableBackgroundColor
                let titleColor = isEnabled ? enableTitleColor : disableTitleColor
                setTitleColor(titleColor, for: .normal)
            case .outlined:
                backgroundColor = .clear
                layer.borderWidth = 1
                layer.borderColor = borderColor.cgColor
                setTitleColor(borderColor, for: .normal)
            case .onlyText:
                backgroundColor = .clear
                setTitleColor(enableTitleColor, for: .normal)
            case .destructive:
                backgroundColor = .clear
                layer.borderWidth = 1
                layer.borderColor = NexoColor.gray1.cgColor
                setTitleColor(NexoColor.redC13018, for: .normal)
            case .disabled:
                backgroundColor = disableBackgroundColor
                setTitleColor(disableTitleColor.withAlphaComponent(0.7) , for: .normal)
        }
    }
}
