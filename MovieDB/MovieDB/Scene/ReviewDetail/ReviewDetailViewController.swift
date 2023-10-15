//
//  ReviewDetailViewController.swift
//  MovieDB
//
//  Created by MacBook on 14.10.2023.
//

import UIKit

class ReviewDetailViewController: UIViewController {
    
    @IBOutlet weak var createdAtReviewLabel: UILabel!
    @IBOutlet weak var contentReviewLabel: UILabel!
    @IBOutlet weak var authorReviewLabel: UILabel!
    @IBOutlet weak var authorAvatarImageView: CustomUIImageView!
    @IBOutlet weak var ratingReviewButton: CustomUIButton!
    
    var review: ReviewResultModel!

    override func viewDidLoad() {
        super.viewDidLoad()
       setReview()
    }
    
    func setReview() {
        contentReviewLabel.text = review.content
        createdAtReviewLabel.text = review.createdAt
        authorReviewLabel.text = review.author
        
        if let rating = review.authorDetails?.rating {
            ratingReviewButton.isHidden = false
            ratingReviewButton.setTitle("\(rating).0", for: .normal)
        }
        
        if let imagePath = review.authorDetails?.avatarPath {
            if let url = Constant.RequestPathMovie.imageUrl(imageSize: .w200, path: imagePath) {
                authorAvatarImageView.loadImage(url: url, placeHolderImage: nil, nil)
            }
        }

    }

}
