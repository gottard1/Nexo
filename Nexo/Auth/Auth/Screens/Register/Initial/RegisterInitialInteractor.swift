//
//  RegisterInitialInteractor.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 02/12/24.
//

import Foundation

protocol RegisterInitialInteractorProtocol: AnyObject {
    func handleButtonTap(action: AuthActions)
}

final class RegisterInitialInteractor: RegisterInitialInteractorProtocol {
    private let presenter: RegisterInitialPresenterProtocol
    private weak var view: RegisterInitialViewProtocol?
    
    init(presenter: RegisterInitialPresenterProtocol) {
        self.presenter = presenter
    }
    
    func handleButtonTap(action: AuthActions) {
        presenter.navigateToNextScreen(action: action)
    }
}
