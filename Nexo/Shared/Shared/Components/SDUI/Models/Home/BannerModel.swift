//
//  BannerModel.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import Foundation

public struct BannerModel: Decodable {
    let icon: String
    let action: String
    let configs: SDUIConfig
}
