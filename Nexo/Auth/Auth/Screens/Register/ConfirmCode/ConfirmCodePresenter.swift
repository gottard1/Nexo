//
//  ConfirmCodePresenter.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 13/12/24.
//

import Foundation

protocol ConfirmCodePresenterProtocol {
    func navigateToNextScreen(action: AuthActions)
    func didValidateCodeFail(with message: String)
}

class ConfirmCodePresenter: ConfirmCodePresenterProtocol {
    weak var view: ConfirmCodeViewProtocol?
    
    init(view: ConfirmCodeViewProtocol) {
        self.view = view
    }
    
    func navigateToNextScreen(action: AuthActions) {
        view?.navigateTo(action: action)
    }
    
    func didValidateCodeFail(with message: String) {
        view?.showErrorAlert(with: message)
    }
}
