//
//  RadioPresenter.swift
//  RadioTest
//
//  Created by Alejandro Arce on 2/11/22.
//

import Foundation
import AVFoundation
//import FRadioPlayer

protocol RadioPresenterDelegate {
    func sendStations(stations: [RadioModel])
    func reproductorLoading()
    func setPause()
    func setPlay()
    func createObserver()
    func restartPlayer()
    func showStatusValuesInScreen(playerItem: AVPlayerItem, player: AVPlayer)
    func setReproductionFailed()
    func sendAlerts(message: String, buttonTitle: String)
}

class RadioPresenter {
    var delegate : RadioPresenterDelegate?
    var myPlayer = AVPlayer()
    var myPlayerItem : AVPlayerItem?
    var playerItemContext = 0
    var myStation: RadioModel?
    //var reachability = Reachability()
    var radioJson : [RadioModel]?
    var favoritesIdList : [Int] = []
    var defaults = UserDefaults.standard
    var cellIdSelected : Int?
    var coordinator : AppCoordinator?
    var jsonError : JsonError?
    
    func getStations() {
        RadioApi.fetchRadioJson { result in
            switch result {
            case .success(let json):
                DispatchQueue.main.async { [self] in
                    print("Descargado Json")
                    self.radioJson = json
                    delegate?.sendStations(stations: radioJson!)
                    coordinator?.setAllStationsToMenuPresenter()
                }
            case .failure(let error):
                print("error")
                print(error)
                DispatchQueue.main.async {
                    switch error {
                        
                    case .missingData:
                        self.jsonError = .missingData
                        print("Sin datos disponibles. Inténtelo de nuevo más tarde")
                        self.delegate?.sendAlerts(message: "Sin datos disponibles. Inténtelo de nuevo más tarde", buttonTitle: "Reintentar")
                    case .codeError:
                        self.jsonError = .codeError
                        print("Servidor ocupado. Inténtelo de nuevo más tarde")
                        self.delegate?.sendAlerts(message: "Servidor ocupado. Inténtelo de nuevo más tarde", buttonTitle: "Reintentar")
                    case .timeOut:
                        self.jsonError = .timeOut
                        print("Servidor tarda en responder. Compruebe su conexión e inténtelo de nuevo más tarde")
                        self.delegate?.sendAlerts(message: "Servidor tarda en responder. Compruebe su conexión e inténtelo de nuevo más tarde", buttonTitle: "Reintentar")
                        
                    case .defaultError:
                        print("Ha ocurrido un error. Inténtelo de nuevo más tarde")
                    }
                    
                }
            }
        }
    }
    func goToMenuVC() {
        coordinator!.goToMenuVC()
    }
    
    func touchCellPlayButton(station : RadioModel) {
        delegate!.reproductorLoading()
        delegate?.restartPlayer()
        myStation = station
        startReproduction()
        
    }
    func observeValue(keyPath: String) {
        switch keyPath {
        case "itemStatus": print("ItemStatus")
            delegate?.showStatusValuesInScreen(playerItem: myPlayerItem!, player: myPlayer)
            switch myPlayerItem?.status {
            case .failed:
                delegate?.setReproductionFailed()
            case .readyToPlay: print("Ready To Play")
            case .unknown: print("Not Ready")
           
            case .none:
                print("none")
            case .some(_):
                print("some")
            }
        case "timeControlStatus":
            delegate?.showStatusValuesInScreen(playerItem: myPlayerItem!, player: myPlayer)
            switch myPlayer.timeControlStatus {
            case .paused:
                print("Time Control Status paused")
                delegate!.setPause()
            case .waitingToPlayAtSpecifiedRate:
                print("Time Control Status waitingToPlayAtSpecifiedRate")
                delegate!.reproductorLoading()
            case .playing:
                print("Time Control Status playing")
                delegate!.setPlay()
            @unknown default:
                print("Time Control Status default")
            }
        
        case "rate":
            delegate?.showStatusValuesInScreen(playerItem: myPlayerItem!, player: myPlayer)
        default: print("Default")
            
        }
    }
    func convertTimeControlStatusToString() -> String {
        switch myPlayer.timeControlStatus {
            
        case .paused:
            return "Paused"
        case .waitingToPlayAtSpecifiedRate:
            return "waitingToPlay"
        case .playing:
            return "Playing"
        @unknown default:
            return "Default"
        }
    }
    func convertItemStatusToString() -> String {
        switch myPlayerItem?.status {
            
        case .readyToPlay:
            return "Ready to play"
        case .failed:
          return "Failed"
        case .unknown:
            return "Unknown"
        case .none:
            return "None"
        @unknown default:
            return "Default"
        }
    }
    func startReproduction() {
        //radioVC?.stationPaused = nil
        let url = URL(string: (myStation?.url)!)
        myPlayerItem = AVPlayerItem(url: url!)
        myPlayer = AVPlayer(playerItem: myPlayerItem)
        let audioSession = AVAudioSession.sharedInstance()
        do {
             try audioSession.setCategory(.playback, mode: .moviePlayback, options: [])
        } catch {
            print("Fallo Audio Session")
        }
        delegate?.createObserver()
//        radioVC?.createObserver(playerItem: myPlayerItem!)
        myPlayer.play()
        //radioVC?.radioView.stationsTableView.reloadData()
    }
    func manageFavourites(cell : RadioTableViewCell) {
        cell.favouriteSelected?.toggle()
        if cell.favouriteSelected == true {
            favoritesIdList.append(cell.id!)
            cell.favouriteButton.isSelected = true
        } else {
            let index = favoritesIdList.firstIndex(of: cell.id!)
            favoritesIdList.remove(at: index!)
            cell.favouriteButton.isSelected = false
        }
        defaults.set(favoritesIdList, forKey: "FavoritesArray")
        coordinator?.favoritesIdList = favoritesIdList
    }
    func changePlayerState(buttonIsSelected: Bool) {
        if buttonIsSelected == true {
            myPlayer.pause()
            delegate?.setPause()
        } else {
            myPlayer.play()
            delegate?.setPlay()
        }
    }

//    func reproductorLoading() {
//        delegate?.reproductorLoading()
//    }
}


