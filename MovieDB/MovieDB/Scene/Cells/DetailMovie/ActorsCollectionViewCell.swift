//
//  ActorsCollectionViewCell.swift
//  MovieDB
//
//  Created by MacBook on 16.08.2023.
//

import UIKit

class ActorsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var actorImageView: UIImageView!
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var actorDepartment: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
