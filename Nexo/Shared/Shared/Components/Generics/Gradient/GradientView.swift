//
//  GradientView.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 02/12/24.
//

import UIKit

public final class GradientView: UIView {
    public var gradientColors: [UIColor]
    
    public init(gradientColors: [UIColor]) {
        self.gradientColors = gradientColors
        super.init(frame: .zero)
        setupGradient()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        (layer.sublayers?.first as? CAGradientLayer)?.frame = bounds
    }
    
    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors.map { $0.cgColor }
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = bounds
        
        layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
