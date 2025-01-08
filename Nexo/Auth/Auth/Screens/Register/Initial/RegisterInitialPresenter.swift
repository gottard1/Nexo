//
//  RegisterInitialPresenter.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 02/12/24.
//

import Foundation

protocol RegisterInitialPresenterProtocol: AnyObject {
    func navigateToNextScreen(action: AuthActions)
}

class RegisterInitialPresenter: RegisterInitialPresenterProtocol {
    weak var view: RegisterInitialViewProtocol?
    
    init(view: RegisterInitialViewProtocol) {
        self.view = view
    }
    
    func navigateToNextScreen(action: AuthActions) {
        view?.navigateTo(action: action)
    }
}
