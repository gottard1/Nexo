//
//  LoginInteractor.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 04/11/24.
//

import Foundation

protocol LoginInteractorProtocol {
    func login(username: String, password: String)
}

class LoginInteractor: LoginInteractorProtocol {
    private let service: LoginServiceProtocol
    private let presenter: LoginPresenterProtocol
    
    init(service: LoginServiceProtocol, presenter: LoginPresenterProtocol) {
        self.service = service
        self.presenter = presenter
    }
    
    func login(username: String, password: String) {
        Task {
            do {
                let token = try await self.service.login(cpfCnpj: username, password: password)
                presenter.presentLoginResult(token: token, error: nil)
            } catch {
                presenter.presentLoginResult(token: nil, error: error)
            }
        }
    }
}
