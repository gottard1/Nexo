//
//  WaveEffectView.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import UIKit

final class WaveEffectView: UIView {
    private var waveLayers: [CAShapeLayer] = []
    private var displayLink: CADisplayLink?
    
    private var waveConfigs: [(amplitude: CGFloat, frequency: CGFloat, speed: CGFloat, verticalOffset: CGFloat, color: UIColor, isLine: Bool)] = []
    
    private var wavePhases: [CGFloat] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        stopWaveAnimation()
    }
    
    // MARK: - Setup
    func setupWaves(withPrimaryColor primaryColor: UIColor) {
        if !waveLayers.isEmpty {
            return
        }
        
        waveConfigs = [
            (amplitude: 23.0, frequency: 0.017, speed: 0.05, verticalOffset: 60.0, color: primaryColor.withAlphaComponent(0.3), isLine: false),
            (amplitude: 25.0, frequency: 0.013, speed: 0.06, verticalOffset: 60.0, color: primaryColor.withAlphaComponent(0.6), isLine: false),
            (amplitude: 27.0, frequency: 0.014, speed: 0.04, verticalOffset: 60.0, color: primaryColor, isLine: true)
        ]
        
        setupWaveLayers()
    }
    
    private func setupWaveLayers() {
        waveLayers.forEach { $0.removeFromSuperlayer() }
        waveLayers.removeAll()
        wavePhases.removeAll()
        
        for config in waveConfigs {
            let layer = CAShapeLayer()
            layer.fillColor = config.isLine ? UIColor.clear.cgColor : config.color.cgColor
            layer.strokeColor = config.isLine ? config.color.cgColor : nil
            layer.lineWidth = config.isLine ? 2.0 : 0.0
            waveLayers.append(layer)
            wavePhases.append(0)
            self.layer.addSublayer(layer)
        }
        startWaveAnimation()
    }
    
    func startWaveAnimation() {
        if displayLink != nil {
            return
        }
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateWaves))
        displayLink?.add(to: .main, forMode: .common)
    }
    
    func stopWaveAnimation() {
        displayLink?.invalidate()
        displayLink = nil
        
        for layer in waveLayers {
            layer.path = nil
        }
        
        waveLayers.forEach { $0.removeFromSuperlayer() }
        waveLayers.removeAll()
        wavePhases.removeAll()
    }
    
    @objc private func updateWaves() {
        guard displayLink != nil else { return }
        
        for (index, layer) in waveLayers.enumerated() {
            wavePhases[index] += waveConfigs[index].speed
            layer.path = createWavePath(amplitude: waveConfigs[index].amplitude,
                                        frequency: waveConfigs[index].frequency,
                                        phase: wavePhases[index],
                                        verticalOffset: waveConfigs[index].verticalOffset).cgPath
        }
    }
    
    private func createWavePath(amplitude: CGFloat, frequency: CGFloat, phase: CGFloat, verticalOffset: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let width = bounds.width
        let height = bounds.height
        let midY = height / 2 + verticalOffset
        
        path.move(to: CGPoint(x: 0, y: midY))
        for x in stride(from: 0, through: width, by: 1) {
            let y = amplitude * sin(frequency * x + phase) + midY
            path.addLine(to: CGPoint(x: x, y: y))
        }
        if amplitude > 0 {
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
        }
        path.close()
        return path
    }
}
