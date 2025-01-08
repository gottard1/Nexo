//
//  ConfirmCodeInteractor.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 13/12/24.
//

import Shared

protocol ConfirmCodeInteractorProtocol {
    var userInfo: RegisterModel { get set }
    func handleButtonTap(action: AuthActions)
    func validateCode(code: ValidateCodeModel, successAction: AuthActions)
    func resendCode()
}

final class ConfirmCodeInteractor: BaseInteractorProtocol, ConfirmCodeInteractorProtocol {
    private let service: RegisterService
    private let presenter: ConfirmCodePresenterProtocol
    
    var userInfo: RegisterModel
    
    init(service: RegisterService, presenter: ConfirmCodePresenterProtocol, with info: RegisterModel) {
        self.service = service
        self.presenter = presenter
        userInfo = info
    }
    
    func handleButtonTap(action: AuthActions) {
        presenter.navigateToNextScreen(action: action)
    }
    
    func validateCode(code: ValidateCodeModel, successAction: AuthActions) {
        handle {
            try await self.service.validateCode(code)
        } completion: { [weak self] result in
            switch result {
                case .success:
                    self?.presenter.navigateToNextScreen(action: successAction)
                case .failure(let error):
                    self?.presenter.didValidateCodeFail(with: error.description)
            }
        }
    }
    
    func resendCode() {
        print(#function)
    }
}
