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
        
        let navigationController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

