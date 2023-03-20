//
//  FeedTableViewCell.swift
//  PhotoShareApp
//
//  Created by Yunus Emre Berdibek on 18.03.2023.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var labelYorum: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var labelEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

