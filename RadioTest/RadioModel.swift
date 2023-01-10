//
//  RadioModel.swift
//  RadioTest
//
//  Created by Alejandro Arce on 31/10/22.
//

import Foundation
import UIKit

struct Record : Decodable {
    let record : RadioModels
}
struct RadioModels: Decodable {
    let radioModels : [RadioModel]
}
struct RadioModel : Decodable {
    let id : Int
    let station : String
    let url : String
    let urlImage : String
    let genre : String
}


