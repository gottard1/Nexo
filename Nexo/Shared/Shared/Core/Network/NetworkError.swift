//
//  NetworkError.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 30/10/24.
//

import Foundation

struct ErrorResponse: Decodable {
    let message: String
}

public enum NetworkError: Error {
    case invalidURL
    case apiError(String)
    case statusCode(Int, String)
    case noData
    case decodingError(Error)
    
    public var description: String {
        switch self {
            case .invalidURL:
                return "A URL é inválida."
            case .apiError(let message):
                return message
            case .statusCode(let statusCode, let message):
                return "\(statusCode): \(message)"
            case .noData:
                return "Nenhum dado foi retornado da API."
            case .decodingError(let error):
                return "Erro ao decodificar a resposta: \(error.localizedDescription)"
        }
    }
}
