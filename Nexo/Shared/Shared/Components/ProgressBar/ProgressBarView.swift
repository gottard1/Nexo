//
//  ProgressBarView.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 02/12/24.
//

import UIKit

public final class ProgressBarView: UIView {
    public let totalSteps: Int
    public var stepHeight: CGFloat = 8
    public var stepColor: UIColor = NexoColor.gray3
    public var completedStepColor: UIColor = NexoColor.mainSecondary
    
    public var currentStep: Int = 1 {
        didSet {
            currentStep = min(max(currentStep, 0), totalSteps)
            updateProgress()
        }
    }
    
    private lazy var stepViews: [UIView] = (1...totalSteps).map { _ in UIView() }
    
    public init(totalSteps: Int) {
        self.totalSteps = totalSteps
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        updateProgress()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        stepViews.forEach {
            $0.backgroundColor = stepColor
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        let totalSpacing: CGFloat = CGFloat(totalSteps - 1) * 2
        let availableWidth = UIScreen.main.bounds.width - totalSpacing
        let stepWidth = availableWidth / CGFloat(totalSteps)
        
        for (index, step) in stepViews.enumerated() {
            step.anchor { make in
                make.height(equalTo: stepHeight)
                
                if index == 0 {
                    make.leading(to: leadingAnchor)
                } else {
                    make.leading(to: stepViews[index - 1].trailingAnchor, constant: 2)
                }
                
                if index == stepViews.count - 1 {
                    make.trailing(to: trailingAnchor)
                }
                
                make.width(equalTo: stepWidth)
            }
        }
    }
    
    private func updateProgress() {
        for (index, view) in stepViews.enumerated() {
            view.backgroundColor = index < currentStep ? completedStepColor : stepColor
        }
    }
}
