//
//  ReviewTableViewCell.swift
//  MovieDB
//
//  Created by MacBook on 14.10.2023.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var createdAtReviewLabel: UILabel!
    @IBOutlet weak var contentReviewLabel: UILabel!
    @IBOutlet weak var authorReviewLabel: UILabel!
    @IBOutlet weak var authorAvatarImageView: CustomUIImageView!
    @IBOutlet weak var ratingReviewButton: CustomUIButton!
    
    var review:ReviewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
