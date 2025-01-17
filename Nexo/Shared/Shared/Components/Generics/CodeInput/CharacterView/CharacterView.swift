//
//  CharacterView.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 13/12/24.
//

import UIKit

final class CharacterView: UIView {
    
    private let characterLabel: UILabel = {
        let label = UILabel()
        label.font = NexoFont.exo2(ofType: .bold, size: 22)
        label.textColor = NexoColor.mainSecondary
        return label
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = NexoColor.mainSecondary
        return view
    }()
    
    var getText: String? {
        get { characterLabel.text }
    }
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .clear
        isUserInteractionEnabled = true
        
        buildHierarchy()
        buildConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupText(_ text: String) {
        characterLabel.text = text
    }
}

// MARK: - Layout
extension CharacterView {
    
    private func buildHierarchy() {
        addSubview(underlineView)
        addSubview(characterLabel)
    }
    
    private func buildConstraints() {
        underlineView.anchor { make in
            make.leading(to: leadingAnchor)
            make.trailing(to: trailingAnchor)
            make.bottom(to: bottomAnchor)
            make.height(equalTo: 4)
        }
        
        characterLabel.anchor { make in
            make.top(to: topAnchor, constant: 8)
            make.bottom(to: underlineView.topAnchor, constant: 8)
            make.centerX(to: underlineView.centerXAnchor)
        }
    }
}

