//
//  SDUIComponent.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import UIKit

enum ComponentType: String, Codable {
    case balanceCard = "balance_card"
    case quickMenuButtons = "quick_menu_buttons"
    case investmentCard = "investment_card"
}

public enum SDUIComponent: Codable {
    case balanceCard(BalanceCardModel)
    case quickMenuButtons(QuickMenuButtonsModel)
    case investmentCard(InvestmentCardsModel)
    
    private enum CodingKeys: String, CodingKey {
        case componentType = "component_type"
        case data
        case config
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(ComponentType.self, forKey: .componentType)
        
        switch type {
            case .balanceCard:
                let data = try container.decode(BalanceCardModel.self, forKey: .data)
                self = .balanceCard(data)
            case .quickMenuButtons:
                let data = try container.decode(QuickMenuButtonsModel.self, forKey: .data)
                if let _ = try? container.decodeIfPresent(SDUIConfig.self,forKey: .config) { }
                self = .quickMenuButtons(data)
            case .investmentCard:
                let data = try container.decode(InvestmentCardsModel.self, forKey: .data)
                if let _ = try? container.decodeIfPresent(SDUIConfig.self,forKey: .config) { }
                self = .investmentCard(data)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
            case .balanceCard(let data):
                try container.encode(ComponentType.balanceCard, forKey: .componentType)
                try container.encode(data, forKey: .data)
            case .quickMenuButtons(let data):
                try container.encode(ComponentType.quickMenuButtons, forKey: .componentType)
                try container.encode(data, forKey: .data)
            case .investmentCard(let data):
                try container.encode(ComponentType.investmentCard, forKey: .componentType)
                try container.encode(data, forKey: .data)
        }
    }
}
