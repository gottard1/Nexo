//
//  RegisterPasswordPresenterProtocol.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 19/12/24.
//

import Shared

protocol RegisterPasswordPresenterProtocol {
    func presentRegisterResult(token: AuthenticateResponse?, error: NetworkError?)
}

class RegisterPasswordPresenter: RegisterPasswordPresenterProtocol {
    weak var view: RegisterPasswordViewProtocol?
    
    init(view: RegisterPasswordViewProtocol) {
        self.view = view
    }
    
    func presentRegisterResult( token: AuthenticateResponse?, error: NetworkError?) {
        DispatchQueue.main.async { [weak self] in
            if let token = token {
                self?.view?.displayRegisterSuccess(with: token)
            } else if let error {
                self?.view?.displayRegisterError(error.description)
            }
        }
    }
}
