//
//  MovieListCollectionViewCell.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: CustomUIImageView!
    @IBOutlet weak var posterIndicator: UIActivityIndicatorView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
