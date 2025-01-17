//
//  WaveEffectView.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import UIKit

public final class WaveEffectView: UIView {
    private let darkWaveLayer = CAShapeLayer()
    private let lightWaveLayer = CAShapeLayer()
    private let lineWaveLayer = CAShapeLayer()
    
    private var waveAnimationDuration: Double = 2.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    private func setupLayers() {
        layer.addSublayer(darkWaveLayer)
        layer.addSublayer(lightWaveLayer)
        layer.addSublayer(lineWaveLayer)
        
        configureLayer(darkWaveLayer, color: UIColor.systemYellow.cgColor, opacity: 1.0)
        configureLayer(lightWaveLayer, color: UIColor.systemYellow.withAlphaComponent(0.6).cgColor, opacity: 1.0)
        configureLayer(lineWaveLayer, color: UIColor.systemYellow.cgColor, opacity: 1.0, isStroke: true)
    }
    
    private func configureLayer(_ layer: CAShapeLayer, color: CGColor, opacity: Float, isStroke: Bool = false) {
        layer.fillColor = isStroke ? nil : color
        layer.strokeColor = isStroke ? color : nil
        layer.opacity = opacity
    }
    
    private func createWavePath(phase: CGFloat) -> CGPath {
        let path = UIBezierPath()
        let width = bounds.width
        let height = bounds.height
        let amplitude: CGFloat = 20.0
        
        path.move(to: .zero)
        for x in stride(from: 0, to: width, by: 1) {
            let y = sin((x / width) * .pi * 2 + phase) * amplitude + height / 2
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.close()
        return path.cgPath
    }
    
    public func startAnimation() {
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = waveAnimationDuration
        animation.repeatCount = .infinity
        animation.autoreverses = true
        animation.fromValue = createWavePath(phase: 0)
        animation.toValue = createWavePath(phase: .pi)
        
        darkWaveLayer.add(animation, forKey: "waveAnimation")
        lightWaveLayer.add(animation, forKey: "waveAnimation")
        lineWaveLayer.add(animation, forKey: "waveAnimation")
    }
    
    public func stopAnimation() {
        darkWaveLayer.removeAllAnimations()
        lightWaveLayer.removeAllAnimations()
        lineWaveLayer.removeAllAnimations()
    }
}
