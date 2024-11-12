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
        
        navigationController.topViewController?.present(modalSheet, animated: true, completion: nil)
    }
}
