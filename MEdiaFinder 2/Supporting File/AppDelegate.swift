//
//  AppDelegate.swift
//  MEdiaFinder 2
//
//  Created by nassermac on 4/19/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - Propreties
    var window: UIWindow?
    let mainStoryBoard:UIStoryboard = UIStoryboard(name:StoryBoards.main, bundle: nil)
    
    //MARK: - Application Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        ApiManger.shared().any()
        SQLiteManger.shared().setupConnection()
        IQKeyboardManager.shared.enable = true
        handleRoot()
        return true
    }
    
    //MARK: - Public Methods
    public func goToSignInVc(){
        let signIn: SignInVC = mainStoryBoard.instantiateViewController(withIdentifier: Views.signIn) as! SignInVC
        let navigationController = UINavigationController(rootViewController: signIn)
        self.window?.rootViewController = navigationController
    }
}

//MARK: - Private Methods
extension AppDelegate{
    private func handleRoot(){
        if let UserLogedIn = UserDefaults.standard.object(forKey: UserDefaultsKeys.isLoggedIn) as? Bool {
            if UserLogedIn{
               goToMediaListVc()
            } else {
                goToSignInVc()
            }
        }
    }

    private func goToMediaListVc(){
        let mediaList: MediaListVC = mainStoryBoard.instantiateViewController(withIdentifier: Views.mediaList) as! MediaListVC
        let navigationController = UINavigationController(rootViewController: mediaList)
        self.window?.rootViewController = navigationController
    }
}

