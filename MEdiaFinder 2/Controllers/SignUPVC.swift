//
//  SignUpVC.swift
//  MEdiaFinder 2
//
//  Created by nassermac on 5/11/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import UIKit
import SDWebImage

class SignUPVC: UIViewController {

    
    //MARK: - OutLet
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    //MARK: - propreties
    private var gender: Gender = .female
    private var imagePicker = UIImagePickerController()
    private var isUserchangedImage: Bool = false
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        SQLiteManger.shared().creatTables()
        super.viewDidLoad()
        self.navigationItem.title = "Sign Up"
        imagePicker.delegate = self
        getImageFromUrl()
       }
    
   
    // MARK: - Actions
    @IBAction func genderSwitchChanged(_ sender: UISwitch) {
        gender = sender.isOn ? .female : .male
    }
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        if isDataEntered(){
         if isDataValid(){ goToSigInVc()}
        }
    }
    @IBAction func addressBtnTapped(_ sender: UIButton) {
        goToMapVc()
    }
    
    @IBAction func userImageBtnTapped(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}
//MARK: - UIImagePickerControllerDelegate,UINavigationControllerDelegate
extension SignUPVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedimage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            userImageView.image = pickedimage
        }
        isUserchangedImage = true
        self.dismiss(animated: true, completion: nil)
    } 
    
}
//MARK: - Private Methods
extension SignUPVC:AddressDelegation {
    private func getImageFromUrl(){
        userImageView.sd_setImage(with: URL(string: "https://www.pngitem.com/pimgs/m/30-307416_profile-icon-png-image-free-download-searchpng-employee.png"), placeholderImage: UIImage(named: "user1"))
    }

    func sentAddress(address: String) {
        addressTextField.text = address
    }

    private func goToSigInVc(){
        let mainStory: UIStoryboard = UIStoryboard(name: StoryBoards.main, bundle: nil)
        let sigInVC: SignInVC = mainStory.instantiateViewController(withIdentifier: Views.signIn) as! SignInVC
        let user: User = User(name: nameTextField.text ?? "" ,
                              mail: mailTextField.text ?? "",
                              phone: phoneTextfield.text ?? "",
                              password: passwordTextField.text ?? "",
                              address: addressTextField.text ?? "",
                              gender: gender ,image: CodableImage.init(withImage: userImageView.image!) )
        SQLiteManger.shared().insertUserAsData(user)
        print("user mail is \(user.mail)")
        print("user password is \(user.password)")
        self.navigationController?.pushViewController(sigInVC, animated: true)
        
    }
 
    private func goToMapVc(){
        let mainStory: UIStoryboard = UIStoryboard(name: StoryBoards.main, bundle: nil)
        let mapVC: MapVC = mainStory.instantiateViewController(withIdentifier: Views.map) as! MapVC
        mapVC.delegate = self
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    private func isDataEntered() -> Bool{
        guard isUserchangedImage != false else {
            showAlert(msg: "Please, Choose an Image ")
            return false }
        guard nameTextField.text != "" else {
            showAlert(msg: "Please, Enter Your Name")
            return false
        }
        guard phoneTextfield.text != "" else {
            showAlert(msg:"Please, Enter Valid Phone. Example : 010 123 456 78")

            return false
        }
        guard mailTextField.text != "" else {
            showAlert(msg: "Please, Enter Valid Email. Example: test@example.com")

            return false
        }
        guard passwordTextField.text != "" else {
            showAlert(msg:"Please, Enter Valid Password. Example:Aa12 ,at least 8 char ")

            return false
        }
        guard addressTextField.text != "" else {
            showAlert(msg: "Please, Enter Your Address")

            return false
        }
        return true
    }
 
    private func isDataValid() -> Bool{
       guard Validator.shared().isValidPhone(phone: phoneTextfield.text!) else {
        showAlert(msg:"Please, Enter Valid Phone. Example : 010 123 456 78")
        return false
        }
        guard Validator.shared().isValidMail(mail: mailTextField.text!) else {
            showAlert(msg:"Please, Enter Valid Email. Example: test@example.com")
            return false
        }
        guard Validator.shared().isValidPassword(password: passwordTextField.text!) else {
            showAlert(msg:"Please, Enter Valid Password. Example:Aa123@*# ")
            return false
        }
     return true
    }
    
}
