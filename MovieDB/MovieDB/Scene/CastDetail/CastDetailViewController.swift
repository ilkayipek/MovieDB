//
//  CastDetailViewController.swift
//  MovieDB
//
//  Created by MacBook on 6.09.2023.
//

import UIKit

class CastDetailViewController: BaseViewController<CastDetailViewModel> {
    @IBOutlet weak var avatarImageView: CustomUIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var knownFor: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var placeOfBirth: UILabel!
    @IBOutlet weak var biography: UILabel!
    @IBOutlet weak var biographyContainterHeightConstraint: NSLayoutConstraint!
    
    var castId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CastDetailViewModel()
        
    }

}
