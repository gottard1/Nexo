//
//  RegisterService.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 18/12/24.
//

import Foundation
import Shared

protocol RegisterServiceProtocol {
    func validateCode(_ code: ValidateCodeModel) async throws
    func register(_ register: RegisterModel) async throws -> AuthenticateResponse
}

final class RegisterService: RegisterServiceProtocol {
    private let networkManager: Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func validateCode(_ code: ValidateCodeModel) async throws {
        let endpoint = RegisterTarget.validateCode(code: code)
        let _ = try await networkManager.request(
            target: endpoint,
            responseType: EmptyResponse.self
        )
    }
    
    func register(_ register: RegisterModel) async throws -> AuthenticateResponse {
        let endpoint = RegisterTarget.register(user: register)
        let response: AuthenticateResponse = try await networkManager.request(
            target: endpoint,
            responseType: AuthenticateResponse.self
        )
        return response
    }
}
