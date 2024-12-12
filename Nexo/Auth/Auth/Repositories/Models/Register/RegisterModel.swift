//
//  RegisterModel.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 11/11/24.
//

import Foundation

struct RegisterModel: Encodable {
    var cpfCnpj: String?
    var email: String?
    var password: String?
    
    enum CodingKeys: String, CodingKey {
        case cpfCnpj = "cpf_cnpj"
        case email
        case password
    }
}

struct RegisterResponse: Decodable {
    var token: String
}
