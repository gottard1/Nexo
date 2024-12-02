//
//  OnboardingInteractor.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 19/11/24.
//

import Foundation

protocol OnboardingInteractorProtocol {
    func handleButtonTap(action: AuthActions)
}

final class OnboardingInteractor: OnboardingInteractorProtocol {
    private let presenter: OnboardingPresenterProtocol
    private weak var view: OnboardingViewProtocol?
    
    init(presenter: OnboardingPresenterProtocol, view: OnboardingViewProtocol) {
        self.presenter = presenter
        self.view = view
    }
    
    func handleButtonTap(action: AuthActions) {
        view?.navigateTo(action: action)
    }
}
 
