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
            case .balanceCard(let model, let config):
                let balanceCardView = BalanceCardView(model: model)
                applyConfig(config, to: balanceCardView)
                return balanceCardView
                
            case .customButton(let models, let config):
                let stackView = createHorizontalStackView()
                models.forEach { model in
                    let buttonView = CustomButton(model: model)
                    stackView.addArrangedSubview(buttonView)
                }
                applyConfig(config, to: stackView)
                return stackView
                
            case .serviceButton(let models, let config):
                let stackView = createHorizontalStackView()
                models.forEach { model in
                    let buttonView = ServiceButton(model: model)
                    stackView.addArrangedSubview(buttonView)
                }
                applyConfig(config, to: stackView)
                return stackView
                
            case .investmentCard(let model, let config):
                let investmentCardView = InvestmentCardView(model: model)
                applyConfig(config, to: investmentCardView)
                return investmentCardView
                
            case .banner(let model, let config):
                let bannerView = BannerView()
                bannerView.setupView(with: model)
                applyConfig(config, to: bannerView)
                return bannerView
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
        
        view.layer.cornerRadius = config.roundedCorners ?? 0
        view.layer.masksToBounds = true
        
        let topSpacer = CGFloat(config.topSpacer)
        let leadingSpacer = CGFloat(config.leadingSpacer)
        let traillingSpacer = CGFloat(config.traillingSpacer)
        let bottomSpacer = CGFloat(config.bottomSpacer)
        
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
