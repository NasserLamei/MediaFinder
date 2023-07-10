//
//  SignInVC.swift
//  MEdiaFinder 2
//
//  Created by nassermac on 4/19/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - Properites
    var maill: String = ""
    var password: String = ""
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sign In"
    }
    
    //MARK: - Actions
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        if isDataEntered() {
            self.isDataValid()
            if isDataIsCorrect() {
                goToMediaListVc()
            }
        }
    }
}

//MARK: - Private Methods
extension SignInVC {
    private func isDataEntered() -> Bool{
        guard mailTextField.text != "" else {
            showAlert(msg: "Please, Enter Your Mail")
            return false
        }
        guard passwordTextField.text != "" else {
            showAlert(msg: "Please, Enter Your Password")
            return false
        }
        return true
    }
    private func isDataIsCorrect() -> Bool{
        if mailTextField.text == self.maill && passwordTextField.text == self.password {
            return true
        }
        showAlert(msg: "The Email Or The Password is Invaild")
        return false
    }
    private func goToMediaListVc(){
        let mainStory: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mediaList: MediaListVC = mainStory.instantiateViewController(withIdentifier: Views.mediaList) as! MediaListVC
        UserdefaultManager.shared().email = mailTextField.text!
        self.navigationController?.pushViewController(mediaList, animated: true)
    }
    
    func isDataValid(){
        if let user = SQLiteManger.shared().getsDataFromSqlDB(mail: mailTextField.text ?? ""){
            self.maill = user.mail
            self.password = user.password
        }
    }
}

