//
//  ViewController.swift
//  RadioTest
//
//  Created by Alejandro Arce on 30/10/22.
//

import UIKit
//import FRadioPlayer
import SideMenu
import AVFoundation
import MediaPlayer

class RadioViewController: UIViewController {
    var radioView = RadioView()
    var radioPresenter : RadioPresenter!
    var myStations : [RadioModel] = []
    var playerContext = 0
    var stationSelected : RadioModel?
    var playingFailed : Bool?
    var stationPaused : Int?
    var loadingScreen = LoadingView()
    var myStationSoundingImage : UIImage?
    let backGroundColor : UIColor = .black
    let tintNormalColor : UIColor = .white
    let tintSelectColor : UIColor = .green
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backGroundColor
  
        radioView.stationsTableView.dataSource = self
        radioView.stationsTableView.delegate = self
        
        radioPresenter.favoritesIdList = radioPresenter.defaults.object(forKey: "FavoritesArray") as? [Int] ?? []
        
        radioView.stationsTableView.register(RadioTableViewCell.self, forCellReuseIdentifier: "RadioTableViewCell")
        
        radioView.playButton.addTarget(self, action: #selector(touchPlayerButton), for: .touchUpInside)
        
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.title = "Emisoras en directo"
        
        view.addSubview(radioView)
        getSafeArea()
        radioView.playerStationLabel.text = "Seleccione emisora"
        radioView.playerStationLabel.textColor = tintNormalColor
        
        playButtonOff()
        view.addSubview(loadingScreen)
        radioPresenter.getStations()
        setupRemoteTransportControls()
        
        
    }
    func getSafeArea() {
        radioView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            radioView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            radioView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            radioView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            radioView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func setupRemoteTransportControls() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()

        // Add handler for Play Command
        commandCenter.playCommand.addTarget { [unowned self] event in
            if self.radioPresenter.myPlayer.rate == 0.0 && radioPresenter.myStation != nil {
                self.radioPresenter.myPlayer.play()
                setPlay()
                return .success
            }
            return .commandFailed
        }

        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            if self.radioPresenter.myPlayer.rate == 1.0 {
                self.radioPresenter.myPlayer.pause()
                setPause()
                return .success
            }
            return .commandFailed
        }
    }
    func setupNowPlaying() {
        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = radioPresenter.myStation?.station
        
        //Define image info
//        if let image = myStationSoundingImage {
//            nowPlayingInfo[MPMediaItemPropertyArtwork] =
//                MPMediaItemArtwork(boundsSize: image.size) { size in
//                    return image
//            }
//        }
//        if let image = myStationSoundingImage {
//            nowPlayingInfo[MPMediaItemPropertyArtwork] =
//                MPMediaItemArtwork(boundsSize: image.size) { size in
//                    return image.imageWith(newSize: size)
//            }
//        }


        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func createObserver(playerItem: AVPlayerItem, player: AVPlayer){
        playerItem.addObserver(self, forKeyPath: "itemStatus", options: [.old, .new], context: &playerContext)
        player.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: &playerContext)
        player.addObserver(self, forKeyPath: "rate", options: [.old, .new], context: &playerContext)

      
    }

    func convertTimeControlStatusToString(timeControlStatus : AVPlayer.TimeControlStatus) -> String {
        switch timeControlStatus {
            
        case .paused:
            print("Time Control Status paused")
            return "Paused"
        case .waitingToPlayAtSpecifiedRate:
            print("Time Control Status waitingToPlayAtSpecifiedRate")
            return "waitingToPlay"
        case .playing:
            print("Time Control Status playing")
            return "Playing"
        @unknown default:
            print("Time Control Status default")
            return "Default"
        }
    }
    func convertItemStatusToString(itemStatus : AVPlayerItem.Status) -> String {
        switch itemStatus {
            
        case .readyToPlay:
            return "Ready to play"
        case .failed:
            return "Failed"
        case .unknown:
            return "Not Ready"
        @unknown default:
            return "Default"
        }
    }
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        radioPresenter.observeValue(keyPath: keyPath!)
    }
    @objc func tapMenuButton() {
        radioPresenter.goToMenuVC()
    }
    
    func audioGifOn() {
        radioView.gifAudio.image = UIImage.gifImageWithName("AudioGif")
    }
    func audioGifOff() {
        radioView.gifAudio.image = nil
    }
    func audioGifLoading() {
        radioView.gifAudio.image = UIImage.gifImageWithName("LoadingGif")
    }
    func playButtonOff() {
        radioView.playButton.setImage(nil, for: .normal)
        radioView.playButton.isSelected = false
    }
    func playButtonPause() {
        radioView.playButton.isSelected = true
    }
    func playButtonPlay() {
        radioView.playButton.setImage(UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 70))), for: .normal)
        radioView.playButton.isSelected = false
        
    }
    @objc func touchPlayerButton() {
        radioPresenter.changePlayerState(buttonIsSelected: radioView.playButton.isSelected)
    }
}
extension RadioViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myStations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RadioTableViewCell", for: indexPath) as! RadioTableViewCell
        cell.backgroundColor = backGroundColor
        let myStation = self.myStations[indexPath.row]
        var myCurrentImage = UIImage()
        cell.id = myStation.id
        cell.station = myStation
        if radioPresenter.favoritesIdList.contains(cell.id!){
            cell.favouriteSelected = true
            cell.favouriteButton.isSelected = true
            cell.favouriteButton.tintColor = tintSelectColor
        } else {
            cell.favouriteSelected = false
            cell.favouriteButton.isSelected = false
            cell.favouriteButton.tintColor = tintNormalColor
        }
        cell.configureOnlyLabel(radio: myStation)
        RadioApi.downloadImages(url: URL(string: myStation.urlImage)!) {
            resultImage in
            switch resultImage{
            case .success(let image):
                DispatchQueue.main.async {
                    cell.stationImage.image = image
                    myCurrentImage = image
                }
            case .failure(_):
                print("Error en la descarga")
            }
        }
        if radioPresenter.cellIdSelected == cell.id && playingFailed == false {
            myStationSoundingImage = myCurrentImage
            //cell.stationLabel.frame = CGRect(x: 65, y: 7.5, width: UIScreen.main.bounds.width - 170, height: 30)
            print(myCurrentImage)
            cell.stationLabel.textColor = tintSelectColor
            cell.gifSpeaker.image = UIImage.gifImageWithName("SpeakerGif")
        }
        
        else {
            cell.gifSpeaker.image = nil
            cell.stationLabel.textColor = tintNormalColor
        }
        if stationPaused == cell.id  {
            cell.gifSpeaker.image = UIImage(named: "Speaker")
        }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(45)
    }
}


extension RadioViewController : RadioTableViewDelegate {
    func tapFavouriteButton(cell: RadioTableViewCell) {
        radioPresenter.manageFavourites(cell: cell)
        let feedbackGenerator = UISelectionFeedbackGenerator()
        feedbackGenerator.selectionChanged()
        self.radioView.stationsTableView.reloadData()
    }
    
    func touchPlayButton(cell: RadioTableViewCell) {
        stationSelected = cell.station
        radioPresenter.touchCellPlayButton(station: cell.station!)
        radioPresenter.cellIdSelected = cell.id
    }
}

extension RadioViewController : RadioPresenterDelegate {
    func sendStations(stations: [RadioModel]) {
        myStations = stations
        radioView.stationsTableView.reloadData()
        loadingScreen.isHidden = true
        radioView.menuButtonItem.target = self
        radioView.menuButtonItem.action = #selector(tapMenuButton)
        navigationItem.rightBarButtonItem = radioView.menuButtonItem
    }
    func showStatusValuesInScreen(playerItem: AVPlayerItem, player: AVPlayer) {
        radioView.statusChangeLabel.text = "Status : \(convertItemStatusToString(itemStatus: playerItem.status)), TCS : \(convertTimeControlStatusToString(timeControlStatus: player.timeControlStatus)), Rate: \(radioPresenter.myPlayer.rate)"
    }
    func reproductorLoading() {
        radioView.playerStationLabel.text = "Conectando"
        radioView.playerStationLabel.textColor = tintNormalColor
        audioGifLoading()
        playButtonOff()
    }
    func setReproductionFailed() {
        print("failed")
        radioView.playerStationLabel.text = "Error al reproducir"
        audioGifOff()
        playButtonOff()
        playingFailed = true
        radioView.stationsTableView.reloadData()
    }
    func setPause() {
        playButtonPlay()
        audioGifOff()
        stationPaused = radioPresenter.cellIdSelected
        radioView.stationsTableView.reloadData()
    }
    func setPlay() {
        playButtonPause()
        audioGifOn()
        stationPaused = nil
        setupNowPlaying()
        radioView.playerStationLabel.text = stationSelected?.station
        radioView.playerStationLabel.textColor = tintSelectColor
        radioView.stationsTableView.reloadData()
    }
    func createObserver() {
        createObserver(playerItem: radioPresenter.myPlayerItem!, player: radioPresenter.myPlayer)
        radioView.stationsTableView.reloadData()
    }
    func restartPlayer() {
        playingFailed = false
        stationPaused = nil
    }
    func sendAlerts(message: String, buttonTitle: String) {
        let alert = UIAlertController(title: "Alerta", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: {_ in
            self.radioPresenter.getStations()
            print("Reintentando")}))
        self.present(alert, animated: true, completion: nil)
    }
}


