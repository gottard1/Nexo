//
//  AppDelegate.swift
//  Nexo
//
//  Created by Marcel Felipe Gottardi Anesi on 23/09/24.
//

import UIKit
import Auth
import Shared

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: Coordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NexoFont.registerFonts()
        window = UIWindow(frame: UIScreen.main.bounds)
        
        setupNavigationControllerAppearence()
        
        let navigationController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        
        return true
    }
    
    private func setupNavigationControllerAppearence() {
        let customAppearance = UINavigationBarAppearance()
        customAppearance.backgroundColor = NexoColor.mainPrimary
        customAppearance.shadowColor = .clear
        
        customAppearance.titleTextAttributes = [
            .foregroundColor: NexoColor.whiteF2F2F2,
            .font: NexoFont.openSans(ofType: .semibold, size: 18)
        ]
        
        customAppearance.largeTitleTextAttributes = [
            .foregroundColor: NexoColor.whiteF2F2F2,
            .font: NexoFont.openSans(ofType: .semibold, size: 34)
        ]
        UINavigationBar.appearance().standardAppearance = customAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = customAppearance
    }
}

