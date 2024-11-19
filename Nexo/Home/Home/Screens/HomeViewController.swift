//
//  HomeViewController.swift
//  Home
//
//  Created by Marcel Felipe Gottardi Anesi on 08/10/24.
//

import UIKit
import Shared

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        let loading = ElasticLoadingView()
        loading.startAnimating()
        
        view.addSubview(loading)
        
        loading.anchor { make in
            make.top(to: view.topAnchor)
            make.bottom(to: view.safeAreaLayoutGuide.bottomAnchor)
            make.leading(to: view.leadingAnchor)
            make.trailing(to: view.trailingAnchor)
        }
    }
}

import UIKit

class ElasticLoadingView: UIView {
    
    private let circleLayer = CAShapeLayer()
    private let animationDuration: CFTimeInterval = 1.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Cria o círculo de carregamento
        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                                radius: bounds.width / 2 - 10,
                                startAngle: 0,
                                endAngle: CGFloat.pi * 2, // Usar CGFloat.pi
                                clockwise: true)
        
        circleLayer.path = path.cgPath
        circleLayer.lineWidth = 5
        circleLayer.strokeColor = UIColor.blue.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        layer.addSublayer(circleLayer)
    }
    
    func startAnimating() {
        // Animação de rotação com efeito elástico
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = CGFloat.pi * 2 // Usar CGFloat.pi
        rotateAnimation.duration = animationDuration
        rotateAnimation.repeatCount = .infinity
        
        // Animação de elasticidade
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.values = [1.0, 1.2, 1.0]
        scaleAnimation.keyTimes = [0, 0.5, 1]
        scaleAnimation.duration = animationDuration
        scaleAnimation.repeatCount = .infinity
        
        // Combina as animações
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [rotateAnimation, scaleAnimation]
        groupAnimation.duration = animationDuration
        groupAnimation.repeatCount = .infinity
        
        circleLayer.add(groupAnimation, forKey: "loadingAnimation")
    }
    
    func stopAnimating() {
        circleLayer.removeAnimation(forKey: "loadingAnimation")
    }
}
