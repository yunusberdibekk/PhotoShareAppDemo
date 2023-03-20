//
//  UploadViewController.swift
//  PhotoSharingApp
//
//  Created by Yunus Emre Berdibek on 17.03.2023.
//

import UIKit
import Firebase
import FirebaseStorage


class UploadViewController: UIViewController {
    
    @IBOutlet weak var yorumTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var resimSecildiMi = false
    
    var ref:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        imageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(imageGestureRecognizer)
    }
    
    
    @IBAction func uploadButtonAction(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()// konum belirltir.
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReference  = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (storageMetadata, error) in
                
                if error != nil {
                    self.hataOlustur(tittle: "Hata", message: error?.localizedDescription ?? "Hata aldınız! ")
                } else{
                    
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            if let imageUrl = imageUrl {
                                
                                let today = Date.now
                                let formatter3 = DateFormatter()
                                formatter3.dateFormat = "HH:mm E, d MMM y"
                                
                                self.veriYükle(email: Auth.auth().currentUser!.email!, yorum: self.yorumTextField.text!, gorsel_url: imageUrl, tarih: formatter3.string(from: today))
                                
                            }
                        } else {
                            self.hataOlustur(tittle: "Hata", message: error?.localizedDescription ?? "Hata aldınız! ")
                        }
                    }
                    
                }
            }
        }
 

    }
    
    func veriYükle(email:String, yorum:String, gorsel_url:String, tarih:String) {
        let dict = ["email":email, "yorum":yorum, "gorsel_url":gorsel_url, "tarih":tarih]
        
        let newRef = self.ref?.child("Post").childByAutoId()
        newRef?.setValue(dict)
        
        self.imageView.image = UIImage(named: "image")
        self.yorumTextField.text = ""
        self.tabBarController?.selectedIndex = 0
    }
    
    
    func hataOlustur(tittle:String, message:String) {
        
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: .alert)
        
        let okButon = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButon)
        self.present(alert,animated: true, completion: nil)
    }
    
    
}

extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func gorselSec() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        resimSecildiMi = true
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
