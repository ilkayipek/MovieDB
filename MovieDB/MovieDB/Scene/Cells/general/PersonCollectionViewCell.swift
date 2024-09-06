//
//  PersonCollectionViewCell.swift
//  MovieDB
//
//  Created by MacBook on 17.02.2024.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var profilImageView: CustomUIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var department: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func loadCell(data: PersonResultModel?) {
        nameLabel.text = data?.name ?? ""
        department.text = data?.knownForDepartment ?? " "
    }

}
