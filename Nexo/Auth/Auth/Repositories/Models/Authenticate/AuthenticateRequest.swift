//
//  AuthenticateRequest.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 11/11/24.
//

import Foundation

struct AuthenticateRequest: Encodable {
    var cpfCnpj: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case cpfCnpj = "cpf_cnpj"
        case password
    }
}

struct AuthenticateResponse: Decodable {
    let token: String?
    let message: String?
}
