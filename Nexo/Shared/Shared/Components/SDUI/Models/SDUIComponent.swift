//
//  SDUIComponent.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import UIKit

enum ComponentType: String, Codable {
    case balanceCard
    case customButton
    case serviceButton
    case investmentCard
    case banner
}

public enum SDUIComponent: Codable {
    case balanceCard(BalanceCardModel)
    case customButton([CustomMenuButtonModel])
    case serviceButton([ServiceMenuButtonModel])
    case investmentCard([InvestmentCardButtonModel])
    case banner([BannerModel])
    
    private enum CodingKeys: String, CodingKey {
        case type
        case data
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(ComponentType.self, forKey: .type)
        
        switch type {
            case .balanceCard:
                let data = try container.decode(BalanceCardModel.self, forKey: .data)
                self = .balanceCard(data)
            case .customButton:
                let data = try container.decode([CustomMenuButtonModel].self, forKey: .data)
                self = .customButton(data)
            case .serviceButton:
                let data = try container.decode([ServiceMenuButtonModel].self, forKey: .data)
                self = .serviceButton(data)
            case .investmentCard:
                let data = try container.decode([InvestmentCardButtonModel].self, forKey: .data)
                self = .investmentCard(data)
            case .banner:
                let data = try container.decode([BannerModel].self, forKey: .data)
                self = .banner(data)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
            case .balanceCard(let data):
                try container.encode(ComponentType.balanceCard, forKey: .type)
                try container.encode(data, forKey: .data)
            case .customButton(let data):
                try container.encode(ComponentType.customButton, forKey: .type)
                try container.encode(data, forKey: .data)
            case .serviceButton(let data):
                try container.encode(ComponentType.serviceButton, forKey: .type)
                try container.encode(data, forKey: .data)
            case .investmentCard(let data):
                try container.encode(ComponentType.investmentCard, forKey: .type)
                try container.encode(data, forKey: .data)
            case .banner(let data):
                try container.encode(ComponentType.banner, forKey: .type)
                try container.encode(data, forKey: .data)
        }
    }
}
