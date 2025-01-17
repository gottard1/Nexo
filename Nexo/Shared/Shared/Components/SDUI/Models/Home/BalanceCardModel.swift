//
//  BalanceCardModel.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import Foundation

public struct BalanceCardModel: Decodable {
    let title: String
    let description: String
    let value: String
    let configs: SDUIConfig
}
