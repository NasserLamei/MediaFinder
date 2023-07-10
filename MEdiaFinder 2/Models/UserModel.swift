//
//  UserModel.swift
//  MEdiaFinder 2
//
//  Created by nassermac on 5/5/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import Foundation
import UIKit
//MARK: - Enum
enum Gender: String,Codable {
    case male = "male"
    case female = "female"
}

//MARK: - Struct
struct User: Codable{
    var name: String
    var mail: String
    var phone: String
    var password: String
    var address: String
    var gender: Gender
    var image: CodableImage
}

struct Movie {
    let movieName: String
    let movieImage: String
}

protocol AddressDelegation:class {
    func sentAddress(address:String)
}

