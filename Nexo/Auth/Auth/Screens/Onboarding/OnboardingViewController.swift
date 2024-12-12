//
//  OnboardingViewController.swift
//  Auth
//
//  Created by Marcel Felipe Gottardi Anesi on 19/11/24.
//

import UIKit

final class OnboardingViewController: UIViewController {
    var interactor: OnboardingInteractorProtocol?
    weak var coordinator: AuthCoordinator?
    
    private let mainView = OnboardingView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupActions() {
        mainView.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        mainView.registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        mainView.accountButton.addTarget(self, action: #selector(didTapAccount), for: .touchUpInside)
    }
    
    @objc private func didTapLogin() {
        interactor?.handleButtonTap(action: .login)
    }
    
    @objc private func didTapRegister() {
        interactor?.handleButtonTap(action: .registerInitial)
    }
    
    @objc private func didTapAccount() {
        interactor?.handleButtonTap(action: .status)
    }
}

extension OnboardingViewController: OnboardingViewProtocol {
    func navigateTo(action: AuthActions) {
        coordinator?.handleNavigation(action: action)
    }
}
