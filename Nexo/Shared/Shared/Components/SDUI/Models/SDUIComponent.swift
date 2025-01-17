//
//  SDUIComponent.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import UIKit

enum ComponentType: String, Decodable {
    case balanceCard
    case customButton
    case serviceButton
    case investmentCard
    case banner
}

public enum SDUIComponent: Decodable {
    case balanceCard(BalanceCardModel, SDUIConfig?)
    case customButton([CustomMenuButtonModel], SDUIConfig?)
    case serviceButton([ServiceMenuButtonModel], SDUIConfig?)
    case investmentCard(InvestmentCardButtonModel, SDUIConfig?)
    case banner(BannerModel, SDUIConfig?)
    
    enum ComponentType: String, Decodable {
        case balanceCard
        case customButton
        case serviceButton
        case investmentCard
        case banner
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
        case data
        case config
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(ComponentType.self, forKey: .type)
        let config = try? container.decode(SDUIConfig.self, forKey: .config)
        
        switch type {
            case .balanceCard:
                let data = try container.decode(BalanceCardModel.self, forKey: .data)
                self = .balanceCard(data, config)
            case .customButton:
                let data = try container.decode([CustomMenuButtonModel].self, forKey: .data)
                self = .customButton(data, config)
            case .serviceButton:
                let data = try container.decode([ServiceMenuButtonModel].self, forKey: .data)
                self = .serviceButton(data, config)
            case .investmentCard:
                let data = try container.decode(InvestmentCardButtonModel.self, forKey: .data)
                self = .investmentCard(data, config)
            case .banner:
                let data = try container.decode(BannerModel.self, forKey: .data)
                self = .banner(data, config)
        }
    }
}
