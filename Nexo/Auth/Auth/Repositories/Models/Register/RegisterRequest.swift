//
//  RegisterRequest.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 11/11/24.
//

import Foundation

struct RegisterRequest: Encodable {
    var cpfCnpj: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case cpfCnpj = "cpf_cnpj"
        case password
    }
}

struct RegisterResponse: Decodable {
    var token: String
}
