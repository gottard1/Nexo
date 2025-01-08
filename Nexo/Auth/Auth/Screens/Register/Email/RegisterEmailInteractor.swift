//
//  RegisterEmailInteractor.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 09/12/24.
//

import Foundation

protocol RegisterEmailInteractorProtocol: AnyObject {
    var userInfo: RegisterModel { get set }
    func handleButtonTap(action: AuthActions)
}

final class RegisterEmailInteractor: RegisterEmailInteractorProtocol {
    private var presenter: RegisterEmailPresenterProtocol
    private weak var view: RegisterEmailViewProtocol?
    
    var userInfo: RegisterModel
    
    init(presenter: RegisterEmailPresenterProtocol, with info: RegisterModel) {
        self.presenter = presenter
        userInfo = info
    }
    
    func handleButtonTap(action: AuthActions) {
        presenter.navigateToNextScreen(action: action)
    }
}
