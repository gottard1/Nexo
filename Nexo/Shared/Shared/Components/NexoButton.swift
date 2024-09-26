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
    
    public var enableBackgroundColor: UIColor = .yellow {
        didSet {
            setupButton()
        }
    }
    
    public var borderColor: UIColor = .yellow {
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
    
    public var disableBackgroundColor: UIColor = .gray {
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
                layer.borderColor = borderColor.cgColor
                setTitleColor(.red, for: .normal)
            case .disabled:
                isEnabled = false
                backgroundColor = disableBackgroundColor
                setTitleColor(disableTitleColor.withAlphaComponent(0.7) , for: .normal)
        }
    }
}
