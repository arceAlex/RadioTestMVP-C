//
//  AppCoordinator.swift
//  RadioTest
//
//  Created by Alejandro Arce on 11/12/22.
//

import Foundation
import UIKit
import SideMenu

class AppCoordinator {
    let navigationController : UINavigationController
    let radioVC = RadioViewController()
    let menuVC = MenuViewController()
    let radioPresenter = RadioPresenter()
    let menuPresenter = MenuPresenter()
    var menu : SideMenuNavigationController?
    var favoritesIdList : [Int]?
    
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
        radioVC.radioPresenter = radioPresenter
        menuVC.menuPresenter = menuPresenter
        radioVC.radioPresenter.coordinator = self
        menuVC.menuPresenter.coordinator = self
        radioPresenter.delegate = radioVC
        menuPresenter.delegate = menuVC
        
        self.navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 15)]
        self.navigationController.navigationBar.barTintColor = .black
        self.navigationController.navigationBar.isTranslucent = false
        self.navigationController.navigationBar.shadowImage = UIImage()
        menu = SideMenuNavigationController(rootViewController: menuVC)
        SideMenuManager.default.rightMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: radioVC.view)
        
    }
    func setAllStationsToMenuPresenter() {
        menuPresenter.allStations = radioPresenter.radioJson
    }
    func start() {
        goToRadioVC()
    }
    func goToRadioVC() {
        favoritesIdList = radioPresenter.favoritesIdList
        navigationController.pushViewController(radioVC, animated: true)
    }
    func goToRadioVCFiltered(stations : [RadioModel]) {
        radioVC.myStations = stations
        radioVC.radioView.stationsTableView.reloadData()
        menuVC.dismiss(animated: true)
    }
    func goToMenuVC() {
        menuPresenter.favoritesIdList = radioPresenter.favoritesIdList
        print("Llegu??")
        radioVC.present(menu!, animated: true)
    }
}
