//
//  HomePresenter.swift
//  Home
//
//  Created by Marcel Felipe Gottardi Anesi on 10/01/25.
//

import Shared
import UIKit

protocol HomePresenterProtocol {
    func presentHomeResult(_ components: [SDUIComponentData]?, error: NetworkError?)
}

final class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    
    init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func presentHomeResult(_ components: [SDUIComponentData]?, error: NetworkError?) {
        DispatchQueue.main.async { [weak self] in
            if let components {
                self?.view?.displayHomeSuccess(with: components)
            } else if let error {
                self?.view?.displayHomeError(error.description)
            }
        }
    }
}
