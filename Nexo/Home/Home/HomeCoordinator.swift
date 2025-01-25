//
//  HomeCoordinator.swift
//  Home
//
//  Created by Marcel Felipe Gottardi Anesi on 08/10/24.
//

import UIKit
import Shared

public final class HomeCoordinator: Coordinator {
    public var navigationController: UINavigationController
    private let networkManager: Networking
    
    private weak var navigationDelegate: FlowNavigator?
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.networkManager = NetworkManager()
    }
    
    public func start() {
        let controller = HomeViewController()
        let service = HomeService(networkManager: networkManager)
        let presenter = HomePresenter(view: controller)
        let interactor = HomeInteractor(presenter: presenter, service: service)
        
        controller.interactor = interactor
        controller.coordinator = self
        
        navigationController.setViewControllers([controller], animated: false)
    }
}
