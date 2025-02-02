//
//  SDUIFactory.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import UIKit

public protocol SDUIComponentViewFactory {
    func buildView(from component: SDUIComponentData, actionHandler: SDUIActionHandler?) -> UIView
}

public protocol SDUIActionHandler: AnyObject {
    func handleAction(_ action: String)
}

public final class SDUIFactory {
    public weak var actionHandler: SDUIActionHandler?
    
    public init() { }
    
    private let componentFactories: [ComponentType: SDUIComponentViewFactory] = [
        .balanceCard: BalanceCardFactory(),
        .quickMenuButtons: QuickMenuButtonsFactory(),
        .investmentCard: InvestmentCardFactory()
    ]
    
    public func createView(for component: SDUIComponentData) -> UIView {
        guard let factory = componentFactories[component.componentType] else {
            return UIView()
        }
        
        return factory.buildView(from: component, actionHandler: actionHandler)
    }
}
