//
//  BalanceCardFactory.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 31/01/25.
//

import UIKit

public final class BalanceCardFactory: SDUIComponentViewFactory, SDUIComponentBaseFactory {
    public var stackView: UIStackView = .init()
    
    public init() { }
    
    public func buildView(from component: SDUIComponentData, actionHandler: SDUIActionHandler?) -> UIView {
        guard let model = component.data as? BalanceCardModel else { return UIView() }
        
        let balanceCardView = BalanceCardView(model: model)
        let containerView = UIView()
        containerView.addSubview(balanceCardView)
        applyConfig(model.config, to: balanceCardView)
        return containerView
    }
    
    private func applyConfig(_ config: SDUIConfig?, to view: UIView) {
        guard let config = config,
              let spacing = config.spacing else { return }
        
        let topSpacer = CGFloat(spacing.topSpacer ?? 0)
        let leadingSpacer = CGFloat(spacing.leadingSpacer ?? 0)
        let trailingSpacer = CGFloat(spacing.trailingSpacer ?? 0)
        let bottomSpacer = CGFloat(spacing.bottomSpacer ?? 0)
        
        guard let superview = view.superview else {
            return
        }
        
        view.anchor { make in
            make.top(to: superview.topAnchor, constant: topSpacer)
            make.leading(to: superview.leadingAnchor, constant: leadingSpacer)
            make.trailing(to: superview.trailingAnchor, constant: trailingSpacer)
            make.bottom(to: superview.bottomAnchor, constant: bottomSpacer)
        }
    }
}
