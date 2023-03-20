//
//  ViewController.swift
//  PhotoSharingApp
//
//  Created by Yunus Emre Berdibek on 17.03.2023.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var sifreTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func girisYapButtonAction(_ sender: Any) {
        if emailTextField.text != "" && emailTextField.text != ""  {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: sifreTextField.text!) { (authDataResult, error) in
                if error != nil {
                    self.hataMesaji(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata Aldınız Tekrar Deneyin")
                } else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            self.hataMesaji(titleInput: "Hata", messageInput: "Email ve Parola Giriniz !")
            
        }
    }
    
    @IBAction func kayitOlButtonAction(_ sender: Any) {
        if emailTextField.text != "" && sifreTextField.text != "" {
            //Kayıt olma işlemi
            Auth.auth().createUser(withEmail: emailTextField.text!, password: sifreTextField.text!) { ( authDataResult, error) in
                if error != nil {
                    self.hataMesaji(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata Aldınız Tekrar Deneyin !!")
                } else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else{
            hataMesaji(titleInput: "Hata", messageInput: "Email ve Parola Giriniz ! ")
        }
    }
    
    func hataMesaji(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}

