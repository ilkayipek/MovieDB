//
//  SimilarCollectionViewCell.swift
//  MovieDB
//
//  Created by MacBook on 27.08.2023.
//

import UIKit

class SimilarCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: CustomUIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
