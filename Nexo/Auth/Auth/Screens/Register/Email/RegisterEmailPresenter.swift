//
//  RegisterEmailPresenter.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 09/12/24.
//

import Foundation

protocol RegisterEmailPresenterProtocol {
    func navigateToNextScreen(action: AuthActions)
}

class RegisterEmailPresenter: RegisterEmailPresenterProtocol {
    weak var view: RegisterEmailViewProtocol?
    
    init(view: RegisterEmailViewProtocol) {
        self.view = view
    }
    
    func navigateToNextScreen(action: AuthActions) {
        view?.navigateTo(action: action)
    }
}
