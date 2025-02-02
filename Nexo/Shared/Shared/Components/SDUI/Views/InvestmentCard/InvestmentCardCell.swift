//
//  InvestmentCardCell.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 26/01/25.
//

import UIKit

final class InvestmentCardCell: UICollectionViewCell {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .regular, size: 16)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.openSans(ofType: .semibold, size: 18)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let waveView: WaveEffectView = {
        let waveView = WaveEffectView()
        return waveView
    }()
    
    private var stopAnimationTimer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        clipsToBounds = true
        
        buildHierarchy()
        buildConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: InvestmentCardModel) {
        titleLabel.text = model.title
        valueLabel.text = String(describing: model.value)
        
        backgroundColor = model.config?.colors?.background?.loadColor
        titleLabel.textColor = model.config?.colors?.textColor?.loadColor
        valueLabel.textColor = model.config?.colors?.descriptionColor?.loadColor
        
        waveView.setupWaves(withPrimaryColor: model.config?.colors?.investmentsColor?.loadColor ?? NexoColor.blue009ED0)
    }
    
    func startAnimation() {
        waveView.startWaveAnimation()
        
        stopAnimationTimer?.invalidate()
        stopAnimationTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
            self?.stopAnimation()
        }
    }
    
    func stopAnimation() {
        waveView.stopWaveAnimation()
        stopAnimationTimer?.invalidate()
        stopAnimationTimer = nil
    }
}

// MARK: - Layout
extension InvestmentCardCell {
    
    private func buildHierarchy() {
        contentView.addSubview(waveView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
    }
    
    private func buildConstraints() {
        waveView.anchor { make in
            make.top(to: contentView.topAnchor)
            make.leading(to: contentView.leadingAnchor)
            make.trailing(to: contentView.trailingAnchor)
            make.bottom(to: contentView.bottomAnchor)
        }
        
        stackView.anchor { make in
            make.centerX(to: contentView.centerXAnchor)
            make.centerY(to: contentView.centerYAnchor)
            make.leading(to: contentView.leadingAnchor, constant: 16)
            make.trailing(to: contentView.trailingAnchor, constant: 16)
        }
    }
}
