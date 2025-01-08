//
//  AuthEndpointsModel.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 11/11/24.
//

import Foundation

struct AuthEndpointsModel {
    static let baseURL = "/auth"
    
    static let login = "\(baseURL)/login"
    static let register = "\(baseURL)/register"
    static let validateCode = "\(baseURL)/email/validateCode"
}
