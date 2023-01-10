//
//  AppDelegate.swift
//  RadioTest
//
//  Created by Alejandro Arce on 30/10/22.
//

import UIKit
import OHHTTPStubs

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator : AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController.init()
        window = UIWindow()
        let bottomSafeArea = window!.safeAreaInsets.bottom
        appCoordinator = AppCoordinator(navigationController: navigationController,bottomSafeArea: bottomSafeArea)
        appCoordinator.start()
//        window = UIWindow()
       // window?.rootViewController = UINavigationController(rootViewController: RadioViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        //let topPadding = window!.safeAreaInsets.top
        //let bottomPadding = window!.safeAreaInsets.bottom
        print(bottomSafeArea)
        let stubPath = OHPathForFile("paso.json", type(of: self))
        stub(condition: isHost("api.jsonbin.io")) { _ in
            return fixture(filePath: stubPath!, headers: ["content_type": "application/json"])
        }
        return true
    }
}

