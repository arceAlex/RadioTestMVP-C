//
//  MenuView.swift
//  RadioTest
//
//  Created by Alejandro Arce on 23/11/22.
//

import Foundation
import UIKit

class MenuView : UIView {
    lazy var todasButton : UIButton = {
        let todasButton = UIButton()
        todasButton.setTitle("Todas", for: .normal)
        todasButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        todasButton.contentHorizontalAlignment = .left
        todasButton.setTitleColor(UIColor.green, for: .normal)
        todasButton.setTitleColor(UIColor.white, for: .highlighted)
        return todasButton
    }()
    var separationLine1 : UIView = {
        let separationLine = UIView(frame: CGRect(x: 20, y: 100, width: 100, height: 1))
        separationLine.backgroundColor = .gray
        return separationLine
    }()
    var separationLine2 : UIView = {
        let separationLine = UIView(frame: CGRect(x: 20, y: 150, width: 100, height: 1))
        separationLine.backgroundColor = .gray
        return separationLine
    }()
    var separationLine3 : UIView = {
        let separationLine = UIView(frame: CGRect(x: 20, y: 200, width: 100, height: 1))
        separationLine.backgroundColor = .gray
        return separationLine
    }()
    lazy var favoritasButton : UIButton = {
        let favoritasButton = UIButton(frame: CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width, height: 50))
        favoritasButton.setTitle("Favoritas", for: .normal)
        favoritasButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        favoritasButton.contentHorizontalAlignment = .left
        favoritasButton.setTitleColor(UIColor.green, for: .normal)
        favoritasButton.setTitleColor(UIColor.white, for: .highlighted)
        return favoritasButton
    }()
    lazy var generosButton : UIButton = {
        let generosButton = UIButton(frame: CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width, height: 50))
        generosButton.setTitle("Géneros  ▲", for: .selected)
        generosButton.setTitle("Géneros  ▼", for: .normal)
        generosButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        generosButton.addTarget(self, action: #selector(showGenrestableView), for: .touchUpInside)
        generosButton.contentHorizontalAlignment = .left
        generosButton.setTitleColor(UIColor.green, for: .normal)
        generosButton.setTitleColor(UIColor.white, for: .highlighted)
        return generosButton
    }()
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .darkGray
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.isHidden = true
        return tableView
      }()
    @objc func showGenrestableView() {
        generosButton.isSelected.toggle()
        tableView.isHidden.toggle()
    }
    init() {
        super.init(frame: UIScreen.main.bounds)
        addSubview(todasButton)
        addSubview(favoritasButton)
        addSubview(generosButton)
        addSubview(tableView)
        addSubview(separationLine1)
        addSubview(separationLine2)
        addSubview(separationLine3)
        setConstraints()
    }
    
    func setConstraints() {
        todasButton.translatesAutoresizingMaskIntoConstraints = false
        favoritasButton.translatesAutoresizingMaskIntoConstraints = false
        generosButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        separationLine1.translatesAutoresizingMaskIntoConstraints = false
        separationLine2.translatesAutoresizingMaskIntoConstraints = false
        separationLine3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            todasButton.topAnchor.constraint(equalTo: topAnchor),
            todasButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            todasButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            todasButton.heightAnchor.constraint(equalToConstant: 50),
            
            separationLine1.topAnchor.constraint(equalTo: todasButton.bottomAnchor),
            separationLine1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            separationLine1.widthAnchor.constraint(equalToConstant: 100),
            separationLine1.heightAnchor.constraint(equalToConstant: 1),
            
            favoritasButton.topAnchor.constraint(equalTo: separationLine1.topAnchor),
            favoritasButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            favoritasButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoritasButton.heightAnchor.constraint(equalToConstant: 50),
            
            separationLine2.topAnchor.constraint(equalTo: favoritasButton.bottomAnchor),
            separationLine2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            separationLine2.widthAnchor.constraint(equalToConstant: 100),
            separationLine2.heightAnchor.constraint(equalToConstant: 1),
            
            generosButton.topAnchor.constraint(equalTo: separationLine2.topAnchor),
            generosButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            generosButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            generosButton.heightAnchor.constraint(equalToConstant: 50),
            
            separationLine3.topAnchor.constraint(equalTo: generosButton.bottomAnchor),
            separationLine3.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            separationLine3.widthAnchor.constraint(equalToConstant: 100),
            separationLine3.heightAnchor.constraint(equalToConstant: 1),
            
            tableView.topAnchor.constraint(equalTo: separationLine3.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor ,constant: -20),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
