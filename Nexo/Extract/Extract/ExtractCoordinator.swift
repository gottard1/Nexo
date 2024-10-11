//
//  ExtractCoordinator.swift
//  Extract
//
//  Created by Marcel Felipe Gottardi Anesi on 07/10/24.
//

import UIKit
import Shared

public final class ExtractCoordinator: Coordinator {
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        // TODO: - Go To Extract Main view
        let controller = UIViewController()
        controller.title = "Extrato"
        controller.view.backgroundColor = .blue
        navigationController.pushViewController(controller, animated: true)
    }
}
