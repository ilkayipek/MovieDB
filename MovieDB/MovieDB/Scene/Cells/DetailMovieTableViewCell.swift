//
//  DetailMovieTableViewCell.swift
//  MovieDB
//
//  Created by MacBook on 17.08.2023.
//

import UIKit

class DetailMovieTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionViewTiltleLabel: UILabel!
    @IBOutlet weak var  collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
