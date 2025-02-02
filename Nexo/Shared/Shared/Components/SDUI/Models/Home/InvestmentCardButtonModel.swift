//
//  InvestmentCardButtonModel.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import Foundation

public struct InvestmentCardModel: Codable {
    let title: String
    let value: Double
    let action: String
    let config: SDUIConfig?
}

public struct InvestmentCardsModel: SDUIComponentModel {
    static var type: ComponentType { .investmentCard }
    let cards: [InvestmentCardModel]
    let config: SDUIConfig?
    
    enum CodingKeys: CodingKey {
        case cards
        case config
    }
}
