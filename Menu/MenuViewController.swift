//
//  MenuVC.swift
//  RadioTest
//
//  Created by Alejandro Arce on 23/11/22.
//

import Foundation
import UIKit

class MenuViewController : UIViewController {
    var menuView = MenuView()
    //var radioVC : RadioViewController?
    var menuPresenter : MenuPresenter!
    var genresArray : [String]?
    var tintColor : UIColor = .darkGray
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = tintColor
        menuView.tableView.dataSource = self
        menuView.tableView.delegate = self
        
        menuView.tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuTableViewCell")
        
        menuView.todasButton.addTarget(self, action: #selector(tapTodasButton), for: .touchUpInside)
        menuView.favoritasButton.addTarget(self, action: #selector(tapFavoritasButton), for: .touchUpInside)
        
                
        self.navigationController?.navigationBar.barTintColor = tintColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.extendedLayoutIncludesOpaqueBars = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        genresArray = menuPresenter.getGenresArray()
        view.addSubview(menuView)
        getSafeArea()
        
    }
    func getSafeArea() {
        menuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            menuView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc func tapTodasButton() {
        menuPresenter.showAllStations()
    }
    @objc func tapFavoritasButton() {
        menuPresenter.showFavoritesStations()
    }
}
extension MenuViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuPresenter.genresArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.backgroundColor = tintColor
        cell.configureLabel(label: genresArray![indexPath.row])
        cell.delegate = self
        return cell
    }
}
extension MenuViewController : MenuTableViewCellDelegate {
    func tapGenreCell(cell: MenuTableViewCell) {
        menuPresenter.filterStations(cell: cell)
    }
}
extension MenuViewController : MenuPresenterDelegate {
    func resetStations() {
        print("Reseteando")
    }
}
