//
//  CardCoordinator.swift
//  Card
//
//  Created by Marcel Felipe Gottardi Anesi on 07/10/24.
//

import UIKit
import Shared

public final class CardCoordinator: Coordinator {
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        // TODO: - Go To Extract Main view
        let controller = UIViewController()
        controller.title = "Cartões"
        controller.view.backgroundColor = .green
        navigationController.pushViewController(controller, animated: true)
    }
}
