//
//  RegisterDocumentPresenter.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 06/12/24.
//

import Foundation

protocol RegisterDocumentPresenterProtocol {
    func navigateToNextScreen(action: AuthActions)
}

class RegisterDocumentPresenter: RegisterDocumentPresenterProtocol {
    weak var view: RegisterDocumentViewProtocol?
    
    init(view: RegisterDocumentViewProtocol) {
        self.view = view
    }
    
    func navigateToNextScreen(action: AuthActions) {
        view?.navigateTo(action: action)
    }
}
