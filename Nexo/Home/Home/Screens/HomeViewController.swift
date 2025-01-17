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
    
    private let homeView: HomeView = .init()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = HomeView()
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
    func displayHomeSuccess(with components: [Shared.SDUIComponent]) {
        
    }
    
    func displayHomeError(_ message: String) {
        
    }
}

