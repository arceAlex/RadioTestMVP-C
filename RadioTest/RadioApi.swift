//
//  RadioApi.swift
//  RadioTest
//
//  Created by Alejandro Arce on 31/10/22.
//

import Foundation
import UIKit

enum JsonError : Error {
    case missingData
    case codeError
    case timeOut
    case defaultError
}
class RadioApi {
    enum jsonError : Error {
        case missingData
    }
    static func fetchRadioJson (completion: @escaping(Result<[RadioModel],JsonError>)->Void) {
        let url = URL(string: "https://api.jsonbin.io/v3/b/63721dbc2b3499323bff5d1e")!
        var compleitionSucces = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 20, execute: {
            if compleitionSucces == false {
                completion(.failure(.timeOut))
                return
            }
        }
        )
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            let response = response as? HTTPURLResponse
            
            if response!.statusCode != 200 && response!.statusCode != 408 {
                print("Error \(response!.statusCode)")
                completion(.failure(.codeError))
                return
            }
            if response!.statusCode == 408 {
                completion(.failure(.timeOut))
                return
            }
            if let _ = error {
                completion(.failure(.defaultError))
                return
            }
            guard let data = data else {
                completion(.failure(.missingData))
                return
            }
            do {
                let json = try JSONDecoder().decode(Record.self, from: data)
                completion(.success(json.record.radioModels))
                compleitionSucces = true
                return
            } catch let error {
                completion(.failure(.defaultError))
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
