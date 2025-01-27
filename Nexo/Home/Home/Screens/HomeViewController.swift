//
//  HomeViewController.swift
//  Home
//
//  Created by Marcel Felipe Gottardi Anesi on 08/10/24.
//

import UIKit
import Shared

protocol HomeViewProtocol: AnyObject {
    func displayHomeSuccess(with components: [SDUIComponent])
    func displayHomeError(_ message: String)
}

final class HomeViewController: UIViewController {
    weak var coordinator: HomeCoordinator?
    var interactor: HomeInteractorProtocol?
    
    private let factory = SDUIFactory()
    
    private let mainView: HomeView = .init()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.fetchHomeData()
    }
}

// MARK: - Presenter Protocol
extension HomeViewController: HomeViewProtocol {
    func displayHomeSuccess(with components: [SDUIComponent]) {
        factory.actionHandler = self
        
        components.forEach { component in
            let newView = factory.createView(for: component)
            mainView.stackView.addArrangedSubview(newView)
        }
    }
    
    func displayHomeError(_ message: String) {
        coordinator?.showCustomAlert(title: "ERRO PORRA", message: message)
    }
}

// MARK: - SDUIFactory action handler
extension HomeViewController: SDUIActionHandler {
    func handleAction(_ action: String) {
        switch action {
            case "plus":
                print("Abrindo Configurações na HomeViewController...")
            case "minus":
                print("Exibindo Perfil do Usuário na HomeViewController...")
            case "teste":
                print("Fazendo Logout na HomeViewController...")
            default:
                print("Ação não reconhecida na HomeViewController: \(action)")
        }
    }
}
