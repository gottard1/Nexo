//
//  NexoLoadingView.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 19/11/24.
//

import UIKit
import Lottie

public final class NexoLoadingView: UIView {
    
    private lazy var animationView: LottieAnimationView = {
        let uiview = LottieAnimationView(name: "loadingAnimation", bundle: Bundle(for: NexoLoadingView.self))
        uiview.contentMode = .scaleAspectFit
        uiview.loopMode = .loop
        return uiview
    }()
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .clear
        addSubview(animationView)
        
        animationView.anchor { make in
            make.top(to: topAnchor)
            make.leading(to: leadingAnchor)
            make.trailing(to: trailingAnchor)
            make.bottom(to: bottomAnchor)
        }
    }
    
    public func startAnimating() {
        animationView.play()
    }
    
    public func stopAnimating() {
        animationView.stop()
    }
}
