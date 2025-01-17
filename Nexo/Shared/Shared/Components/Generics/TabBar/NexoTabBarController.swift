//
//  NexoTabBarController.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 08/10/24.
//

import UIKit

public final class NexoTabBarController: UITabBarController {
    
    private var tabBarItems: [NexoTabBarItemModel] = NexoTabBarItemModel.allCases
    
    private let mainView: NexoTabBarView = .init()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = NexoColor.whiteF2F2F2
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarHeight = tabBar.frame.height
        let frame = CGRect(
            x: 0,
            y: view.frame.height - tabBarHeight - 40,
            width: view.frame.width,
            height: 100
        )
        
        mainView.frame = frame
        view.addSubview(mainView)
        
        addTabBarItemsToStackView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.isHidden = true
    }
    
    private func addTabBarItemsToStackView() {
        for (index, itemModel) in tabBarItems.enumerated() {
            let tabBarItem = NexoTabBarItem(model: itemModel)
            tabBarItem.isSelected = (index == 0)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabBarItemTapped(_:)))
            tabBarItem.addGestureRecognizer(tapGesture)
            tabBarItem.tag = index
            
            mainView.stackView.addArrangedSubview(tabBarItem)
        }
    }
    
    @objc private func tabBarItemTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        selectTab(at: index)
    }
    
    private func selectTab(at index: Int) {
        self.selectedIndex = index
        
        for (i, view) in mainView.stackView.arrangedSubviews.enumerated() {
            if let tabBarItem = view as? NexoTabBarItem {
                tabBarItem.isSelected = (i == index)
            }
        }
    }
}
