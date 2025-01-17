//
//  PresentationController.swift
//  Shared
//
//  Created by Marcel Felipe Gottardi Anesi on 11/11/24.
//

import UIKit

protocol PresentationDismissProtocol {
    func userDidDismiss()
}

public final class PresentationController: UIPresentationController {
    
    let blurEffectView: UIVisualEffectView = .init(effect: UIBlurEffect(style: .dark))
    lazy var tapGestureRecognizer: UITapGestureRecognizer = .init(target: self, action: #selector(dismissController))
    
    public override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isUserInteractionEnabled = true
        blurEffectView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    public override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        let safeAreaFrame = containerView.bounds.inset(by: containerView.safeAreaInsets)
        
        let targetWidth = safeAreaFrame.width
        let fittingSize = CGSize(
            width: targetWidth,
            height: UIView.layoutFittingCompressedSize.height
        )
        
        let targetHeight = presentedViewController.view.systemLayoutSizeFitting(
            fittingSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        ).height
        
        let origin = CGPoint(x: 0, y: containerView.frame.height - targetHeight - containerView.safeAreaInsets.bottom)
        let size = CGSize(width: containerView.frame.width, height: targetHeight + containerView.safeAreaInsets.bottom)
        return CGRect(origin: origin, size: size)
    }
    
    public override func presentationTransitionWillBegin() {
        self.blurEffectView.alpha = 0
        self.containerView?.addSubview(blurEffectView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.alpha = 0.7
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
    }
    
    public override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.alpha = 0
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.removeFromSuperview()
        })
    }
    
    public override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.roundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner], radius: 22)
    }
    
    public override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }
    
    @objc func dismissController() {
        if let presentedVC = self.presentedViewController as? PresentationDismissProtocol {
            presentedVC.userDidDismiss()
        } else {
            self.presentedViewController.dismiss(animated: true)
        }
    }
    
}
