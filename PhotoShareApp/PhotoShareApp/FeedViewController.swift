//
//  FeedViewController.swift
//  PhotoSharingApp
//
//  Created by Yunus Emre Berdibek on 17.03.2023.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postList = [Post]()
    
    var ref:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference()
        
        tumVerileriGetir()
    }
    
    func tumVerileriGetir() {
        
        ref?.child("Post").observe(.value, with: { snapshot in
            
            if let gelenVeriButunu = snapshot.value as? [String:Any] {
                self.postList.removeAll()
                
                for gelenSatirVerisi in gelenVeriButunu {
                    
                    if let sozluk = gelenSatirVerisi.value as? NSDictionary {
                        
                        let key = gelenSatirVerisi.key
                        
                        let post_id = String(key)
                        let email = sozluk["email"] as? String ?? ""
                        let yorum = sozluk["yorum"] as? String ?? ""
                        let tarih = sozluk["tarih"] as? String ?? ""
                        let gorsel_url = sozluk["gorsel_url"] as? String ?? ""
                        
                        self.postList.append(Post(post_id: post_id, email: email, yorum: yorum, tarih: tarih, gorsel_url: gorsel_url))
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        })
    }
    
    
    
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedTableViewCell
        
        cell.labelEmail.text = postList[indexPath.row].email!
        cell.labelYorum.text = postList[indexPath.row].yorum!
        cell.postImageView.sd_setImage(with: URL(string: self.postList[indexPath.row].gorsel_url!))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
