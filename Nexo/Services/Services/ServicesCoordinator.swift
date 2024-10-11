//
//  ServicesCoordinator.swift
//  Services
//
//  Created by Marcel Felipe Gottardi Anesi on 07/10/24.
//

import UIKit
import Shared

public final class ServicesCoordinator: Coordinator {
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        // TODO: - Go To Extract Main view
        let controller = UIViewController()
        controller.title = "Serviços"
        controller.view.backgroundColor = .yellow
        navigationController.pushViewController(controller, animated: true)
    }
}
