//
//  InvestmentCardButtonModel.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import Foundation

public struct InvestmentCardButtonModel: Codable {
    let title: String
    let description: String
    let action: String
    let configs: SDUIConfig
}
