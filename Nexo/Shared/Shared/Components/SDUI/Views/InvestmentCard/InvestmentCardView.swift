//
//  InvestmentCardView.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 17/01/25.
//

import UIKit

final class InvestmentCardView: UIView {
    
    private lazy var cardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 160)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(InvestmentCardCell.self, forCellWithReuseIdentifier: "teste")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 12
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPageIndicatorTintColor = NexoColor.mainSecondary
        control.pageIndicatorTintColor = NexoColor.gray2
        control.numberOfPages = model.cards.count
        control.transform = CGAffineTransform(rotationAngle: .pi / 2)
        control.currentPage = 0
        return control
    }()
    
    private var autoScrollTimer: Timer?
    private var indexOfCellBeforeDragging = 0
    private var destinationCellAfterDragging: Int?
    
    private let model: InvestmentCardsModel
    
    var actionHandler: (() -> Void)?
    
    init(model: InvestmentCardsModel) {
        self.model = model
        super.init(frame: .zero)
        buildHierarchy()
        buildConstraints()
        startAutoScrollTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        autoScrollTimer?.invalidate()
    }
    
    private func startAutoScrollTimer() {
        guard model.cards.count > 1 else { return }
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 10.0,
                                               target: self,
                                               selector: #selector(showNextCard),
                                               userInfo: nil,
                                               repeats: true)
    }
    
    private func stopAutoScrollTimer() {
        autoScrollTimer?.invalidate()
    }
    
    @objc private func showNextCard() {
        let nextIndex = (indexOfCellBeforeDragging + 1) % model.cards.count
        scrollToPage(index: nextIndex)
        pageControl.currentPage = nextIndex
    }
    
    private func scrollToPage(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        cardCollectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        indexOfCellBeforeDragging = index
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension InvestmentCardView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teste", for: indexPath) as? InvestmentCardCell else {
            return UICollectionViewCell()
        }
        
        let model = model.cards[indexPath.item]
        cell.configure(with: model)
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.y / scrollView.frame.height)
        pageControl.currentPage = pageIndex
        indexOfCellBeforeDragging = pageIndex
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopAutoScrollTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startAutoScrollTimer()
    }
}

// MARK: - Layout
extension InvestmentCardView {
    
    private func buildHierarchy() {
        addSubview(cardCollectionView)
        addSubview(pageControl)
    }
    
    private func buildConstraints() {
        cardCollectionView.anchor { make in
            make.top(to: topAnchor)
            make.leading(to: leadingAnchor)
            make.trailing(to: trailingAnchor)
            make.bottom(to: bottomAnchor)
        }
        
        pageControl.anchor { make in
            make.centerY(to: centerYAnchor)
            make.trailing(to: trailingAnchor, constant: 4)
            make.height(equalTo: 20)
        }
    }
}
