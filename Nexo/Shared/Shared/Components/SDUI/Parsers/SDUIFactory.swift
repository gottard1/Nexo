//
//  SDUIFactory.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import UIKit

class SDUIFactory {
    func createView(for component: SDUIComponent) -> UIView {
        switch component {
            case .balanceCard(let model):
                let balanceCardView = BalanceCardView(model: model)
                applyConfig(model.configs, to: balanceCardView)
                return balanceCardView
            case .customButton(let models):
                let stackView = createHorizontalStackView()
                models.forEach { model in
                    let buttonView = CustomButton(model: model)
                    stackView.addArrangedSubview(buttonView)
                    applyConfig(model.configs, to: buttonView)
                }
                return stackView
            case .serviceButton(let models):
                let stackView = createHorizontalStackView()
                models.forEach { model in
                    let buttonView = ServiceButton(model: model)
                    stackView.addArrangedSubview(buttonView)
                    applyConfig(model.configs, to: buttonView)
                }
                return stackView
            case .investmentCard(let models):
                let stackView = createHorizontalStackView()
                models.forEach { model in
                    let investmentCardView = InvestmentCardView(model: model)
                    stackView.addArrangedSubview(investmentCardView)
                    applyConfig(model.configs, to: investmentCardView)
                }
                return stackView
            case .banner(let models):
                let stackView = createHorizontalStackView()
                models.forEach { model in
                    let bannerView = BannerView()
                    bannerView.setupView(with: model)
                    stackView.addArrangedSubview(bannerView)
                    applyConfig(model.configs, to: bannerView)
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
        guard let config = config else { return }
        
        view.layer.masksToBounds = true
        
        let topSpacer = CGFloat(config.spacing.topSpacer)
        let leadingSpacer = CGFloat(config.spacing.leadingSpacer)
        let traillingSpacer = CGFloat(config.spacing.traillingSpacer)
        let bottomSpacer = CGFloat(config.spacing.bottomSpacer)
        
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
