//
//  ServiceMenuButtonModel.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import Foundation

public struct ServiceMenuButtonModel: Decodable {
    let title: String
    let icon: String
    let action: String
    let configs: SDUIConfig
}
