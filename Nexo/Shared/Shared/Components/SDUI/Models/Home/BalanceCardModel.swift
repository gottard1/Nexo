//
//  BalanceCardModel.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import Foundation

public struct BalanceCardModel: SDUIComponentModel {
    static var type: ComponentType { .balanceCard }
    let value: Double
    let icon: String
    let config: SDUIConfig?
    
    enum CodingKeys: String, CodingKey {
        case value
        case icon
        case config
    }
}
