//
//  RegisterInitialViewController.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 02/12/24.
//

import Shared
import UIKit

protocol RegisterInitialViewProtocol: AnyObject {
    func navigateTo(action: AuthActions)
}

final class RegisterInitialViewController: UIViewController {
    var interactor: RegisterInitialInteractorProtocol?
    weak var coordinator: AuthCoordinator?
    
    private let mainView = RegisterInitialView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backButton.addTarget(nil, action: #selector(backButtonAction), for: .touchUpInside)
        mainView.nextButton.addTarget(nil, action: #selector(nextButtonAction), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - Action
extension RegisterInitialViewController {
    
    @objc private func backButtonAction() {
        coordinator?.dismissRegister()
    }
    
    @objc private func nextButtonAction() {
        interactor?.handleButtonTap(action: .registerDocument)
    }
}

// MARK: - View protocol
extension RegisterInitialViewController: RegisterInitialViewProtocol {
    func navigateTo(action: AuthActions) {
        coordinator?.handleNavigation(action: action)
    }
}
