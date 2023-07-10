//
//  UserdefaultManager.swift
//  MEdiaFinder 2
//
//  Created by nassermac on 5/11/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import Foundation

class UserdefaultManager{
    
    //MARK: - propierties
    private let def = UserDefaults.standard
    private static let sharedInstance = UserdefaultManager()
    
    //MARK: - methods
    class func shared()->UserdefaultManager{
        return UserdefaultManager.sharedInstance
    }
    
    func convertUserIntoData(_ user: User){
        let encoder = JSONEncoder()
        if let encoderUser = try? encoder.encode(user){
            def.setValue(encoderUser, forKey: UserDefaultsKeys.user)
        }
    }
    func convertDataIntoUser()->User?{
        if let userData = def.object(forKey: UserDefaultsKeys.user) as? Data{
            let decoder = JSONDecoder()
            if let decoderUser = try? decoder.decode(User.self, from: userData){
                return decoderUser
            }
        }
        return nil
    }
    var email: String {
        set {
            def.set(newValue, forKey: UserDefaultsKeys.token )
        }
        get {
            guard def.object(forKey: UserDefaultsKeys.token ) != nil else {
                return "N/A"
            }
            return def.string(forKey: UserDefaultsKeys.token )!
        }
    }
}
// i can make that in extention only (init) ...

//struct Person {
//    var name:String
//    var age: Int?
//}
//
//extension Person{
//
//    init(name:String){
//        self.name = name
//
//    }
//}
//let a = Person(name: "Nasser", age: 27)
//let b = Person(name: "Wagee")

