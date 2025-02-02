//
//  ComponentMapper.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 31/01/25.
//

import UIKit

enum ComponentType: String, Codable {
    case balanceCard = "balance_card"
    case quickMenuButtons = "quick_menu_buttons"
    case investmentCard = "investment_card"
}

protocol SDUIComponentModel: Codable {
    static var type: ComponentType { get }
}

class ComponentMapper {
    static let componentMap: [ComponentType: SDUIComponentModel.Type] = [
        .balanceCard: BalanceCardModel.self,
        .quickMenuButtons: QuickMenuButtonsModel.self,
        .investmentCard: InvestmentCardsModel.self
    ]
}
