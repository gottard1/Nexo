//
//  SDUIFactory.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import UIKit

public final class SDUIFactory {
    public init() { }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createView(for component: SDUIComponent) -> UIView {
        switch component {
            case .balanceCard(let models):
                let stackView = createHorizontalStackView()
                models.forEach { model in
                    let balanceCardView = BalanceCardView(model: model)
                    applyConfig(model.config, to: balanceCardView)
                    stackView.addArrangedSubview(balanceCardView)
                }
                return stackView
            case .serviceButton(let models):
                let stackView = createHorizontalStackView()
                models.forEach { model in
                    let buttonView = ServiceButton(model: model)
                    applyConfig(model.config, to: buttonView)
                    stackView.addArrangedSubview(buttonView)
                }
                return stackView
        }
    }
    
    private func createHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }
    
    private func applyConfig(_ config: SDUIConfig?, to view: UIView) {
        guard let config = config,
              let spacing = config.spacing else { return }
        
        view.layer.masksToBounds = true
        
        let topSpacer = CGFloat(spacing.topSpacer ?? 16.0)
        let leadingSpacer = CGFloat(spacing.leadingSpacer ?? 16.0)
        let traillingSpacer = CGFloat(spacing.traillingSpacer ?? 16.0)
        let bottomSpacer = CGFloat(spacing.bottomSpacer ?? 16.0)
        
        if let superview = view.superview {
            view.anchor { make in
                make.top(to: superview.topAnchor, constant: topSpacer)
                make.leading(to: superview.leadingAnchor, constant: leadingSpacer)
                make.trailing(to: superview.trailingAnchor, constant: traillingSpacer)
                make.bottom(to: superview.bottomAnchor, constant: bottomSpacer)
            }
        }
    }
}
