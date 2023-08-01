//
//  MovieCollectionTableViewCell.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

import UIKit

class MovieCollectionTableViewCell: UITableViewCell {
    @IBOutlet weak var moviCollectionView: UICollectionView!
    @IBOutlet weak var collectionTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
