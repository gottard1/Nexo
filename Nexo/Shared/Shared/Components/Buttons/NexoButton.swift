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
    private var originalTitle: String?
    private let loadingView = NexoLoadingView()
    
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
    
    public typealias ButtonBlock = (NexoButton) -> Void
    
    private var action: ButtonBlock? {
        didSet {
            self.addTarget(self, action: #selector(onTapAction(sender:)), for: .touchUpInside)
        }
    }
    
    public var isLoading: Bool = false {
        didSet {
            updatePresentation()
        }
    }
    
    public init(style: ButtonStyle = .filled) {
        super.init(frame: .zero)
        self.buttonStyle = style
        setupButton()
        setupLoadingView()
        
        layer.cornerRadius = 16
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        anchor { make in
            make.height(equalTo: 50)
        }
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
                setTitleColor(isEnabled ? enableTitleColor : disableTitleColor, for: .normal)
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
                setTitleColor(NexoColor.failure, for: .normal)
            case .disabled:
                backgroundColor = disableBackgroundColor
                setTitleColor(disableTitleColor.withAlphaComponent(0.7), for: .normal)
        }
    }
    
    @objc func onTapAction(sender: NexoButton) {
        action?(sender)
    }
    
    public func onTap(_ action: @escaping ButtonBlock) {
        self.action = action
    }
    
    // MARK: - Loading View
    private func setupLoadingView() {
        loadingView.isHidden = true
        addSubview(loadingView)
        
        loadingView.anchor { make in
            make.centerX(to: centerXAnchor)
            make.centerY(to: centerYAnchor)
            make.height(equalTo: 20)
            make.width(equalTo: 20)
        }
    }
    
    private func updatePresentation() {
        if isLoading {
            originalTitle = originalTitle ?? title(for: .normal)
            setTitle(nil, for: .normal)
            loadingView.isHidden = false
            loadingView.startAnimating()
        } else {
            setTitle(originalTitle, for: .normal)
            loadingView.isHidden = true
            loadingView.stopAnimating()
        }
    }
}
