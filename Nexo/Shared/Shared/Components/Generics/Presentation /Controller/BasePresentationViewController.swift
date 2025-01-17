//
//  BasePresentationViewController.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 11/11/24.
//

import UIKit

open class BasePresentViewController: UIViewController, PresentationDismissProtocol {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func instantiateForModal() -> UIViewController {
        let selfInstance = self.init()
        selfInstance.modalPresentationStyle = .custom
        selfInstance.transitioningDelegate = selfInstance
        return selfInstance
    }
    
    open func userDidDismiss() {}
    
}

extension BasePresentViewController: UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
