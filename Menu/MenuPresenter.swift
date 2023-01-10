//
//  MenuPresenter.swift
//  RadioTest
//
//  Created by Alejandro Arce on 23/11/22.
//

import Foundation

protocol MenuPresenterDelegate {
    func resetStations()
}

class MenuPresenter {
    var delegate : MenuPresenterDelegate?
    var coordinator : AppCoordinator?
    var genresArray : [String] = []
    var allStations : [RadioModel]?
    var favoritesIdList : [Int]?
    
    func showAllStations() {
        coordinator?.goToRadioVCFiltered(stations: allStations!)
    }
    func showFavoritesStations() {
        favoritesIdList = coordinator?.favoritesIdList
        var myStations = allStations
        var jsonFiltered : [RadioModel] = []
        guard favoritesIdList != [] else {
            myStations = []
            coordinator?.goToRadioVCFiltered(stations: myStations!)
            return
        }
        for station in (myStations)! {
            for favourite in (favoritesIdList)! where favourite == station.id {
                jsonFiltered.append(station)
                myStations = jsonFiltered
            }
        }
        coordinator?.goToRadioVCFiltered(stations: myStations!)
    }
    
    func filterStations(cell: MenuTableViewCell) {
        let charToRemove : String = " •"
        var myGenre : String = ""
        myGenre = (cell.genreButton.titleLabel?.text)!
        myGenre.removeAll(where: {charToRemove.contains($0)})
        print(myGenre)
        filterGenres(genre: myGenre)
    }
    func filterGenres(genre : String){
        let jsonFiltered = allStations!.filter{$0.genre == genre}
        coordinator?.goToRadioVCFiltered(stations: jsonFiltered)
    }
    func getGenresArray() -> [String] {
        for station in allStations! {
            genresArray.append(station.genre)
        }
        var genresArrayFiltered : [String] = []
        for genre in genresArray{
            if !genresArrayFiltered.contains(genre) {
                genresArrayFiltered.append(genre)
            }
        }
        genresArray = genresArrayFiltered
        return genresArray
    }
}
