//
//  TabBarCoordinator.swift
//  Nexo
//
//  Created by Marcel Felipe Gottardi Anesi on 10/10/24.
//

import UIKit
import Shared
import Home

final class TabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    private var homeCoordinator: HomeCoordinator?
    
    private let tabBarController: NexoTabBarController = .init()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        setupTabCoordinators()
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
    private func setupTabCoordinators() {
        let homeNavController = UINavigationController()
        homeCoordinator = HomeCoordinator(navigationController: homeNavController)
        homeCoordinator?.start()
        
        tabBarController.viewControllers = [
            homeNavController,
        ]
    }
    
    private func selectCoordinator(at index: Int) {
        switch index {
//            case 0:
            default:
                homeCoordinator?.start()
//                servicesCoordinator?.start()
        }
    }
}
