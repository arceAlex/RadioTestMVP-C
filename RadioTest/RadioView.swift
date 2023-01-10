//
//  RadioListView.swift
//  RadioTest
//
//  Created by Alejandro Arce on 30/10/22.
//

import Foundation
import UIKit

class RadioView : UIView {
    
    var stationsTableView : UITableView = {
        let stationsTableView = UITableView()
//        stationsTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 80)
        stationsTableView.allowsSelection = false
        stationsTableView.backgroundColor = .black
        stationsTableView.separatorStyle = .none
        
        return stationsTableView
    }()
    var rectanglePlayer : UIView = {
//        let rectanglePlayer = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width, height: 80))
//        let rectanglePlayer = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width, height: 80))
        let rectanglePlayer = UIView()
        //rectanglePlayer.backgroundColor = .blue
        //rectanglePlayer.backgroundColor = UIColor(hue: 0.6833, saturation: 1, brightness: 0.45, alpha: 1.0)
        
        return rectanglePlayer
    }()
    var separationLine : UIView = {
        let separationLine = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        separationLine.backgroundColor = UIColor(red: 0.3843, green: 0.4235, blue: 0.549, alpha: 1.0)
        return separationLine
    }()
    var playButton : UIButton = {
        let playButton = UIButton()
        playButton.frame = CGRect(x: 20, y: 20, width: 40, height: 40)
        playButton.setImage(UIImage(systemName: "pause.circle", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 50))), for: .selected)
        playButton.tintColor = .green
        return playButton
    }()
    var playerStationLabel : UILabel = {
        let playerStationLabel = UILabel(frame: CGRect(x: 80, y: 25, width: UIScreen.main.bounds.width - 160, height: 30))
        playerStationLabel.textColor = .white
        playerStationLabel.font = playerStationLabel.font.withSize(14)
        playerStationLabel.textAlignment = .center
        //playerStationLabel.backgroundColor = .yellow
        return playerStationLabel
    }()
    var gifAudio : UIImageView = {
        let gifAudio = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 60, y: 15, width: 40, height: 40))
      //  gifAudio.backgroundColor = .black
        return gifAudio
    }()
    var menuButtonItem : UIBarButtonItem = {
        let menuButtonItem = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"))
        menuButtonItem.tintColor = .white
        
        return menuButtonItem
    }()
    var statusChangeLabel : UILabel = {
        let statusChangeLabel = UILabel(frame: CGRect(x: 0, y: 60, width: UIScreen.main.bounds.width, height: 20))
       // statusChangeLabel.backgroundColor = .black
        statusChangeLabel.font = statusChangeLabel.font.withSize(12)
        statusChangeLabel.text = "Hola"
        statusChangeLabel.textColor = .white
        return statusChangeLabel
    }()
    var myView : UIView = {
        let myView = UIView()
        myView.backgroundColor = .red
        return myView
    }()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        
        //super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 300))
        //clipsToBounds = true
        config()
    }
    
    func config() {
        
        rectanglePlayer.addSubview(playButton)
        rectanglePlayer.addSubview(playerStationLabel)
        rectanglePlayer.addSubview(gifAudio)
        //rectanglePlayer.addSubview(statusChangeLabel)
        
        rectanglePlayer.translatesAutoresizingMaskIntoConstraints = false
        stationsTableView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stationsTableView)
        addSubview(rectanglePlayer)
        NSLayoutConstraint.activate([
            stationsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stationsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stationsTableView.topAnchor.constraint(equalTo: topAnchor),
            stationsTableView.bottomAnchor.constraint(equalTo: rectanglePlayer.topAnchor),
            
            rectanglePlayer.leadingAnchor.constraint(equalTo: leadingAnchor),
            rectanglePlayer.trailingAnchor.constraint(equalTo: trailingAnchor),
            rectanglePlayer.heightAnchor.constraint(equalToConstant: 80),
            rectanglePlayer.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
