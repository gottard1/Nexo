//
//  LoginInteractor.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 04/11/24.
//

import Foundation
import Shared

protocol LoginInteractorProtocol {
    func login(username: String, password: String)
}

class LoginInteractor: BaseInteractorProtocol, LoginInteractorProtocol {
    private let service: LoginServiceProtocol
    private let presenter: LoginPresenterProtocol
    
    init(service: LoginServiceProtocol, presenter: LoginPresenterProtocol) {
        self.service = service
        self.presenter = presenter
    }
    
    func login(username: String, password: String) {
        handle {
            try await self.service.login(cpfCnpj: username, password: password)
        } completion: { result in
            switch result {
                case .success(let token):
                    self.presenter.presentLoginResult(token: token, error: nil)
                case .failure(let error):
                    self.presenter.presentLoginResult(token: nil, error: error)
            }
        }
    }
}
