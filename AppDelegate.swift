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
        //let bottomSafeArea = window!.safeAreaInsets.bottom
        //appCoordinator = AppCoordinator(navigationController: navigationController,bottomSafeArea: bottomSafeArea)
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        //print(bottomSafeArea)

        return true
    }
}

