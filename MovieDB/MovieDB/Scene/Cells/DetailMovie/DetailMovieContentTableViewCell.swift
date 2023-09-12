//
//  DetailMovieContentTableViewCell.swift
//  MovieDB
//
//  Created by MacBook on 26.08.2023.
//

import UIKit

class DetailMovieContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var overViewArrowButon: UIButton!
    @IBOutlet weak var overViewTextView: UITextView!
    @IBOutlet weak var overViewContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var createdAtReviewLabel: UILabel!
    @IBOutlet weak var contentReviewLabel: UILabel!
    @IBOutlet weak var authorReviewLabel: UILabel!
    @IBOutlet weak var authorAvatarImageView: CustomUIImageView!
    @IBOutlet weak var ratingReviewButton: CustomUIButton!
    @IBOutlet weak var moreReviewsButton: CustomUIButton!
    @IBOutlet weak var reviewStrackView: UIStackView!
    @IBOutlet weak var reviewUIView: UIView!
    
    var reviewsModel: ReviewModel?
    var isExpanded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setOverView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func setOverView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        overViewTextView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        overViewTextView.becomeFirstResponder()
        let symbolConfiguration = UIImage.SymbolConfiguration(scale: .small)
        if !isExpanded {
            let heightOutsideOverView = overViewContainerHeightConstraint.constant - overViewTextView.frame.size.height
            let fixedWidth = overViewTextView.frame.size.width
            let overViewNewSize = overViewTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newHeightContainer = overViewNewSize.height + heightOutsideOverView
            
            if overViewContainerHeightConstraint.constant < newHeightContainer {
                overViewContainerHeightConstraint.constant = newHeightContainer
                
                overViewArrowButon.setImage(UIImage(systemName: IconeName.arrowChevronUp.rawValue,withConfiguration: symbolConfiguration), for: .normal)
                
                if let tableView = self.superview as? UITableView {
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }
            }
        } else {
            overViewContainerHeightConstraint.constant = 100
            
            overViewArrowButon.setImage(UIImage(systemName: IconeName.arrowChevronDown.rawValue,withConfiguration: symbolConfiguration), for: .normal)
            
            if let tableView = self.superview as? UITableView {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
        isExpanded = !isExpanded
    }
    
    func setReviews() {
        //if there is no data, the tableView resize is updated and the review UIView remains invisible.
        if !(reviewsModel?.results?.isEmpty ?? true) {
            if let review = reviewsModel?.results?[0] {
                reviewUIView.isHidden = false
                setReviewStackView()
                
                if let avatarPath = review.authorDetails?.avatarPath {
                    guard let url = Constant.RequestPathMovie.imageUrl(imageSize: .original, path: avatarPath) else {return}
                    authorAvatarImageView.loadImage(url: url, placeHolderImage: nil, nil)
                }
                
                authorReviewLabel.text = review.author
                contentReviewLabel.text = review.content
                createdAtReviewLabel.text = review.createdAt
                
                if let rating = review.authorDetails?.rating {
                    ratingReviewButton.isHidden = false
                    ratingReviewButton.setTitle("\(rating).0", for: .normal)
                }
                
                if let result = reviewsModel?.results, (reviewsModel?.results?.count ?? 0) > 1 {
                    moreReviewsButton.isHidden = false
                    moreReviewsButton.setTitle("  Real All Reviews(\(result.count))  ", for: .normal)
                }
            }
        } else {
            if let tableView = self.superview as? UITableView {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
    }
    
    //MARK: when the reviewS tackView is touched, the function that will redirect to the review detail page runs.
    private func setReviewStackView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(transitionDetailReview))
        reviewStrackView.addGestureRecognizer(tapGesture)
    }
    
    @objc func transitionDetailReview() {
        if let review = reviewsModel?.results?[0] {
            //transition Detail review
        }
    }
}
