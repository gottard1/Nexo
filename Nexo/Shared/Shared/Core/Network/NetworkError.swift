//
//  NetworkError.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 30/10/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case apiError(Error)
    case statusCode(Int)
    case noData
    case decodingError(Error)
}
