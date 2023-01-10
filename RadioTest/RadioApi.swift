//
//  RadioApi.swift
//  RadioTest
//
//  Created by Alejandro Arce on 31/10/22.
//

import Foundation
import UIKit

class RadioApi {
    enum jsonError : Error {
        case missingData
    }
    static func fetchRadioJson (completion: @escaping(Result<[RadioModel],Error>)->Void) {
        let url = URL(string: "https://api.jsonbin.io/v3/b/63721dbc2b3499323bff5d1e")!
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(jsonError.missingData))
                return
            }
            do {
                let json = try JSONDecoder().decode(Record.self, from: data)
                completion(.success(json.record.radioModels))
                return
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
                return
            }
        }.resume()
    }
    static func downloadImages(url: URL, completionImage: @escaping(Result<UIImage,Error>)->Void){
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Ha habido un error")
                completionImage(.failure(error!))
                return
            }
            if let image = UIImage(data: data) {
                completionImage(.success(image))
            }
        }.resume()
    }
}

//let radioJson = [
//    RadioModel(station: "Los 40", url: "https://25633.live.streamtheworld.com/LOS40_SC", image:"Los40"),
//    RadioModel(station: "Hit FM", url: "https://bbhitfm.kissfmradio.cires21.com/bbhitfm.mp3?wmsAuthSign=c2VydmVyX3RpbWU9MTEvMDIvMjAyMiAxMDoyNTowNyBQTSZoYXNoX3ZhbHVlPU56dXZobW9XS1ZPVFp5dnJkMERsK2c9PSZ2YWxpZG1pbnV0ZXM9MTQ0MCZpZD00NDA3MTQxMw==", image: "HitFM")
//]

//hitFmForbidden: https://bbhitfm.kissfmradio.cires21.com/bbhitfm.mp3?wmsAuthSign=c2VydmVyX3RpbWU9MTEvMDIvMjAyMiAxMDoyNTowNyBQTSZoYXNoX3ZhbHVlPU56dXZobW9XS1ZPVFp5dnJkMERsK2c9PSZ2YWxpZG1pbnV0ZXM9MTQ0MCZpZD00NDA3MTQxMw==
//hitFmOk: https://bbhitfm.kissfmradio.cires21.com/bbhitfm.mp3?wmsAuthSign=c2VydmVyX3RpbWU9MTEvMDQvMjAyMiAwNTowODoyMCBQTSZoYXNoX3ZhbHVlPWRqWWJ6QXQzbDdMcUZucFN1ellvY3c9PSZ2YWxpZG1pbnV0ZXM9MTQ0MCZpZD00NDczMzY3NQ==
