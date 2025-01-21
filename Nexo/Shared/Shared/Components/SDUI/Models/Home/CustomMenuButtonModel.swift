//
//  CustomMenuButtonModel.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import Foundation

public struct CustomMenuButtonModel: Codable {
    let title: String
    let icon: String
    let action: String
    let config: SDUIConfig
}
