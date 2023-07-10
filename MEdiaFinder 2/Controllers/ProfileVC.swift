//
//  HomeVC.swift
//  MEdiaFinder 2
//
//  Created by nassermac on 4/20/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var userImageview: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var adderssLabel: UILabel!

    
    //MARK: - Properties
    private let def = UserDefaults.standard
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUserData()
        isDatavalid()
    }
 
// MARK: - Private Actions
    @IBAction func loggedOutbtnTapped(_ sender: UIButton) {
        logoutAction()
    }
  
}


// MARK: - Private Methods
extension ProfileVC {
 
    
  
    func isDatavalid(){
        let mail = UserdefaultManager.shared().email
        if let user = SQLiteManger.shared().getsDataFromSqlDB(mail: mail){
            nameLabel.text = user.name
            mailLabel.text = user.mail
            phoneLabel.text = user.phone
            genderLabel.text = user.gender.rawValue
            adderssLabel.text = user.address
            userImageview.image = user.image.getImage()
            
        }
    }
}

extension ProfileVC {
  private func logoutAction(){
        def.setValue(false, forKey: UserDefaultsKeys.isLoggedIn)
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            appDelegate.goToSignInVc()
        }
    }

  
}
