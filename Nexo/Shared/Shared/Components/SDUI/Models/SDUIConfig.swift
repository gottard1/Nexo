//
//  SDUIConfig.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import UIKit

public struct SDUIConfig: Codable {
    let colors: SDUIColor?
    let spacing: SDUISpacing?
}

public struct SDUIColor: Codable {
    var background: String?
    var borderColor: String?
    var iconColor: String?
    var textColor: String?
    var descriptionColor: String?
    var investmentsColor: String?
}

public struct SDUISpacing: Codable {
    let topSpacer: Double?
    let leadingSpacer: Double?
    let trailingSpacer: Double?
    let bottomSpacer: Double?
}
