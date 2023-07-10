//
//  Constans.swift
//  MEdiaFinder 2
//
//  Created by nassermac on 4/28/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import Foundation

//MARK: - StoryBoards
struct StoryBoards {
    static let main: String = "Main"
}

//MARK: - Views
struct Views {
    static let signUp: String = "SignUpVC"
    static let signIn: String = "SignInVC"
    static let profile: String = "ProfileVC"
    static let map: String = "MapVC"
    static let mediaList: String = "MediaListVC"
    
    
}

//MARK: - UserDefaults
struct UserDefaultsKeys {
    static let isLoggedIn: String = "IsLoggedIn"
    static let user: String = "user"
    static let token: String = "token"
}
//MARK: - URLs
struct URLs {
    static let base = "https://dummy.restapiexample.com"
    static let employee = base + "/api/v1/employees"
    static let search = "https://itunes.apple.com/search?"
}
