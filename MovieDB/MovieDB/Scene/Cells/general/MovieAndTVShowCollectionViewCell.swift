//
//  MovieListCollectionViewCell.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

import UIKit

class MovieAndTVShowCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: CustomUIImageView!
    @IBOutlet weak var posterIndicator: UIActivityIndicatorView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadCell(model: MovieAndTVShowsModelResult) {
        if let name = model.name {
            self.name.text = name
        } else if let title = model.title {
            self.name.text = title
        }else if let originalName = model.originalName {
            self.name.text = originalName
        } else {
            self.name.text = model.originalTitle
        }
        
        if let date = model.releaseDate {
            self.date.text = model.releaseDate
        } else {
            self.date.text = model.firstAirDate
        }
         
        
        if let url = Constant.RequestPathMovie.imageUrl(imageSize: .w200, path: model.posterPath) {
            posterImage.loadImage(url: url, placeHolderImage: nil) { _, _, _, _ in
                self.posterIndicator.stopAnimating()
            }
        }
       
    }

}
