//
//  SDUIFactory.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import UIKit

public protocol SDUIActionHandler: AnyObject {
    func handleAction(_ action: String)
}

public final class SDUIFactory {
    private let stackView = UIStackView()
    
    public weak var actionHandler: SDUIActionHandler?
    
    public init() { }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createView(for component: SDUIComponent) -> UIView {
        switch component {
            case .balanceCard(let model):
                let balanceCardView = BalanceCardView(model: model)
                let containerView = UIView()
                containerView.addSubview(balanceCardView)
                applyConfig(model.config, to: balanceCardView)
                return containerView
            case .quickMenuButtons(let models):
                let scrollView = createScrollableHorizontalStackView(height: 90)
                if let stackView = scrollView.subviews.first(where: { $0 is UIStackView }) as? UIStackView {
                    models.buttons.forEach { model in
                        let buttonView = QuickMenuButton(model: model)
                        
                        buttonView.actionHandler = { [weak self] in
                            self?.actionHandler?.handleAction(model.action)
                        }
                        
                        buttonView.anchor { make in
                            make.width(equalTo: 76)
                        }
                        stackView.addArrangedSubview(buttonView)
                    }
                }
                return scrollView
            case .investmentCard(let model):
                let investmentCardView = InvestmentCardView(model: model)
                let containerView = UIView()
                containerView.addSubview(investmentCardView)
                
                containerView.anchor { make in
                    make.height(equalTo: 200)
                }
                applyConfig(model.config, to: investmentCardView)
                return containerView
        }
    }
}

// MARK: - Helpers
extension SDUIFactory {
    
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
