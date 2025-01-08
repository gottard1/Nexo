//
//  RegisterPasswordInteractor.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 19/12/24.
//

import Shared

protocol RegisterPasswordInteractorProtocol {
    var userInfo: RegisterModel { get set }
    func register()
}

final class RegisterPasswordInteractor: BaseInteractorProtocol, RegisterPasswordInteractorProtocol {
    private let service: RegisterService
    private let presenter: RegisterPasswordPresenterProtocol
    
    var userInfo: RegisterModel
    
    init(service: RegisterService, presenter: RegisterPasswordPresenterProtocol, with info: RegisterModel) {
        self.service = service
        self.presenter = presenter
        userInfo = info
    }
    
    func register() {
        handle {
            try await self.service.register(self.userInfo)
        } completion: { [weak self] result in
            switch result {
                case .success(let token):
                    self?.presenter.presentRegisterResult(token: token, error: nil)
                case .failure(let error):
                    self?.presenter.presentRegisterResult(token: nil, error: error)
            }
        }
    }
}
