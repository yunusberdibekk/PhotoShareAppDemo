//
//  Post.swift
//  PhotoShareApp
//
//  Created by Yunus Emre Berdibek on 18.03.2023.
//

import Foundation

class Post {
    
    var post_id:String?
    var email:String?
    var yorum:String?
    var tarih:String?
    var gorsel_url:String?
    
    init() {}
    
    init(post_id:String, email: String, yorum: String, tarih: String, gorsel_url: String) {
        
        self.post_id = post_id
        self.email = email
        self.yorum = yorum
        self.tarih = tarih
        self.gorsel_url = gorsel_url
    }
    
    
}
