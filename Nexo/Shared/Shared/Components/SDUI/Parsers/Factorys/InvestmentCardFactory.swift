//
//  InvestmentCardFactory.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 31/01/25.
//

import UIKit

public final class InvestmentCardFactory: SDUIComponentViewFactory, SDUIComponentBaseFactory {
    public var stackView = UIStackView()
    
    public init() { }
    
    public func buildView(from component: SDUIComponentData, actionHandler: SDUIActionHandler?) -> UIView {
        guard let model = component.data as? InvestmentCardsModel else { return UIView() }
        
        let investmentCardView = InvestmentCardView(model: model)
        let containerView = UIView()
        containerView.addSubview(investmentCardView)
        
        containerView.anchor { make in
            make.height(equalTo: 200)
        }
        applyConfig(model.config, to: investmentCardView)
        return containerView
    }
    
    private func createScrollableHorizontalStackView(height: CGFloat) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        
        stackView.axis = .horizontal
        stackView.spacing = 28
        stackView.distribution = .fillEqually
        
        scrollView.addSubview(stackView)
        
        stackView.anchor { make in
            make.top(to: scrollView.contentLayoutGuide.topAnchor)
            make.leading(to: scrollView.contentLayoutGuide.leadingAnchor, constant: 20)
            make.trailing(to: scrollView.contentLayoutGuide.trailingAnchor, constant: 20)
            make.bottom(to: scrollView.contentLayoutGuide.bottomAnchor)
            make.height(equalTo: height)
        }
        
        scrollView.anchor { make in
            make.height(equalTo: height)
        }
        
        return scrollView
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
