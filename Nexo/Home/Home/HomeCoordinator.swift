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
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let controller = UIViewController()
        controller.title = "Home"
        controller.view.backgroundColor = .brown
        navigationController.pushViewController(controller, animated: true)
    }
}
