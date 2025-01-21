//
//  BaseTarget.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 30/10/24.
//

import Foundation

public protocol BaseTarget {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryParameters: [String: String]? { get }
    var body: Data? { get }
}
