//
//  RegisterDocumentInteractor.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 06/12/24.
//

import Foundation

protocol RegisterDocumentInteractorProtocol {
    func handleButtonTap(action: AuthActions)
}

final class RegisterDocumentInteractor: RegisterDocumentInteractorProtocol {
    private let presenter: RegisterDocumentPresenterProtocol
    private weak var view: RegisterDocumentViewProtocol?
    
    init(presenter: RegisterDocumentPresenterProtocol) {
        self.presenter = presenter
    }
    
    func handleButtonTap(action: AuthActions) {
        presenter.navigateToNextScreen(action: action)
    }
}
