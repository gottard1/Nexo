//
//  Coordinator.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 30/09/24.
//

import UIKit

public protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
    func showCustomAlert(
        title: String,
        message: String?,
        customTitle: String,
        customHandler: (() -> Void)?,
        cancelTitle: String?,
        cancelHandler: (() -> Void)?
    )
}

public extension Coordinator {
    func currentViewController(from base: UIViewController? = nil) -> UIViewController? {
        let rootViewController: UIViewController? = base ?? {
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }?.rootViewController
        }()
        
        guard let base = rootViewController else { return nil }
        
        if let navigationController = base as? UINavigationController {
            return currentViewController(from: navigationController.visibleViewController)
        }
        
        if let tabBarController = base as? UITabBarController,
           let selectedVC = tabBarController.selectedViewController {
            return currentViewController(from: selectedVC)
        }
        
        if let presentedVC = base.presentedViewController {
            return currentViewController(from: presentedVC)
        }
        
        return base
    }
    
    func showCustomAlert(
        title: String,
        message: String?,
        customTitle: String = "OK",
        customHandler: (() -> Void)? = nil,
        cancelTitle: String? = nil,
        cancelHandler: (() -> Void)? = nil
    ) {
        var buttons: [ButtonInformation] = [
            .init(
                text: customTitle,
                type: .plain,
                shouldDismissWhenClicked: true,
                action: customHandler
            )
        ]
        
        if let cancelTitle = cancelTitle {
            let cancelButton = ButtonInformation(
                text: cancelTitle,
                type: .outlined,
                shouldDismissWhenClicked: true,
                action: cancelHandler
            )
            buttons.append(cancelButton)
        }
        
        let description = NSAttributedString(string: message ?? "")
        
        let modalSheet = ModalBottomSheetView(
            title: title,
            description: description,
            shouldDismiss: true,
            buttons: buttons
        )
        
        DispatchQueue.main.async {
            self.currentViewController()?.present(modalSheet, animated: true, completion: nil)
        }
    }
}
