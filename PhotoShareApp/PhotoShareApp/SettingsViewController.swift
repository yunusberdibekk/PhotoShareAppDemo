//
//  SettingsViewController.swift
//  PhotoSharingApp
//
//  Created by Yunus Emre Berdibek on 17.03.2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cikisYapButtonAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toLoginVC", sender: nil)
        } catch  {
            print("Hata")
        }
    }

}
