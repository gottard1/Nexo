//
//  SDUIComponent.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import UIKit

enum ComponentType: String, Codable {
    case balanceCard = "balance_card"
    case serviceButton = "service_button"
}

public enum SDUIComponent: Codable {
    case balanceCard([BalanceCardModel])
    case serviceButton([ServiceMenuButtonModel])
    
    private enum CodingKeys: String, CodingKey {
        case componentType = "component_type"
        case data
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(ComponentType.self, forKey: .componentType)
        
        switch type {
            case .balanceCard:
                let data = try container.decode([BalanceCardModel].self, forKey: .data)
                self = .balanceCard(data)
            case .serviceButton:
                let data = try container.decode([ServiceMenuButtonModel].self, forKey: .data)
                self = .serviceButton(data)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
            case .balanceCard(let data):
                try container.encode(ComponentType.balanceCard, forKey: .componentType)
                try container.encode(data, forKey: .data)
            case .serviceButton(let data):
                try container.encode(ComponentType.serviceButton, forKey: .componentType)
                try container.encode(data, forKey: .data)
        }
    }
}
