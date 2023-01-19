//
//  AppDelegate.swift
//  RadioTest
//
//  Created by Alejandro Arce on 30/10/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator : AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController.init()
        window = UIWindow()
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}

