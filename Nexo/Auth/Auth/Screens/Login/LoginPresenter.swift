//
//  LoginPresenter.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 04/11/24.
//

import Foundation

protocol LoginViewProtocol: AnyObject {
    func displayLoginSuccess(with token: AuthenticateResponse)
    func displayLoginError(_ message: String)
}

protocol LoginPresenterProtocol {
    func presentLoginResult(token: AuthenticateResponse?, error: Error?)
}

class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    
    init(view: LoginViewProtocol) {
        self.view = view
    }
    
    func presentLoginResult(token: AuthenticateResponse?, error: Error?) {
        DispatchQueue.main.async { [weak self] in
            if let token = token {
                self?.view?.displayLoginSuccess(with: token)
            } else {
                let message = error?.localizedDescription ?? "Login failed."
                self?.view?.displayLoginError(message)
            }
        }
    }
}
