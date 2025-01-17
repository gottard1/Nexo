//
//  HomeInteractor.swift
//  Home
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import Shared

protocol HomeInteractorProtocol {
    func fetchHomeData()
}

final class HomeInteractor: BaseInteractorProtocol, HomeInteractorProtocol {
    private let presenter: HomePresenterProtocol
    private let service: HomeServiceProtocol
    
    init(presenter: HomePresenterProtocol, service: HomeServiceProtocol) {
        self.presenter = presenter
        self.service = service
    }
    
    func fetchHomeData() {
        let request = HomeDataRequest(cpfCnpj: "0796004691")
        
        handle {
            try await self.service.fetchHome(parameters: request)
        } completion: {  [weak self] result in
            switch result {
                case .success(let homeComponents):
                    self?.presenter.presentHomeResult(homeComponents, error: nil)
                case .failure(let error):
                    self?.presenter.presentHomeResult(nil, error: error)
            }
        }
    }
}
