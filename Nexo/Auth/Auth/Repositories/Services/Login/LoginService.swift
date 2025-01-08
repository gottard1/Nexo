//
//  LoginService.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 04/11/24.
//

import Shared
import UIKit

protocol LoginServiceProtocol {
    func login(cpfCnpj: String, password: String) async throws -> AuthenticateResponse
}

class LoginService: LoginServiceProtocol {
    private let networkManager: Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func login(cpfCnpj: String, password: String) async throws -> AuthenticateResponse {
        let request = AuthenticateRequest(cpfCnpj: cpfCnpj, password: password)
        let endpoint = LoginTarget.authenticate(object: request)
        let response: AuthenticateResponse = try await networkManager.request(
            target: endpoint,
            responseType: AuthenticateResponse.self
        )
        return response
    }
}
