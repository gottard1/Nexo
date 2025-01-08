//
//  LoginPresenter.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 04/11/24.
//

import Shared

protocol LoginPresenterProtocol {
    func presentLoginResult(token: AuthenticateResponse?, error: NetworkError?)
}

class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    
    init(view: LoginViewProtocol) {
        self.view = view
    }
    
    func presentLoginResult(token: AuthenticateResponse?, error: NetworkError?) {
        DispatchQueue.main.async { [weak self] in
            if let token = token {
                self?.view?.displayLoginSuccess(with: token)
            } else {
                let message = error?.description ?? "Login failed."
                self?.view?.displayLoginError(message)
            }
        }
    }
}
