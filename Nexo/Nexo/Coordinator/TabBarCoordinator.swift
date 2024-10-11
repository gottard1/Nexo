//
//  TabBarCoordinator.swift
//  Nexo
//
//  Created by Marcel Felipe Gottardi Anesi on 10/10/24.
//

import UIKit
import Shared
import Extract
import Card
import Services
import Home

final class TabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    private var homeCoordinator: HomeCoordinator?
    private var extractCoordinator: ExtractCoordinator?
    private var cardCoordinator: CardCoordinator?
    private var servicesCoordinator: ServicesCoordinator?
    
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
        
        let extractNavController = UINavigationController()
        extractCoordinator = ExtractCoordinator(navigationController: extractNavController)
        extractCoordinator?.start()
        
        let cardNavController = UINavigationController()
        cardCoordinator = CardCoordinator(navigationController: cardNavController)
        cardCoordinator?.start()
        
        let servicesNavController = UINavigationController()
        servicesCoordinator = ServicesCoordinator(navigationController: servicesNavController)
        servicesCoordinator?.start()
        
        tabBarController.viewControllers = [
            homeNavController,
            extractNavController,
            cardNavController,
            servicesNavController
        ]
    }
    
    private func selectCoordinator(at index: Int) {
        switch index {
            case 0:
                homeCoordinator?.start()
            case 1:
                extractCoordinator?.start()
            case 2:
                cardCoordinator?.start()
            default:
                servicesCoordinator?.start()
        }
    }
}
