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
    @IBOutlet weak var biographyContainerView: CustomContainerUIView!
    @IBOutlet weak var biographyContainterHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imdbButton: CustomUIButton!
    @IBOutlet weak var facebookButton: CustomUIButton!
    @IBOutlet weak var twitterButton: CustomUIButton!
    @IBOutlet weak var instagramButton: CustomUIButton!
    @IBOutlet weak var webButton: CustomUIButton!
    @IBOutlet weak var webVerticalLineView: UIView!
    
    var castId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CastDetailViewModel()
        setDetailInfos()
        setExternalIdButtons()
    }
    
    private func setDetailInfos(){
        if let castId {
            viewModel?.getPersonDetail(personId: castId) { [weak self] data in
                guard let self else {return}
                if let data {
                    if let avatarPath = data.profilePath {
                        if let url = Constant.RequestPathMovie.imageUrl(imageSize: .original, path: avatarPath) {
                            self.avatarImageView.loadImage(url: url, placeHolderImage: nil) { _, _, _, _ in
                                // animating stop
                            }
                        }
                    }
                    
                    if let homePageWebUrl = data.homepage {
                        self.webButton.isHidden = false
                        self.webVerticalLineView.isHidden = false
                    }
                    
                    if let biography = data.biography {
                        self.biographyContainerView.isHidden = false
                        self.biography.text = data.biography
                    }
                    
                    self.nameLabel.text = data.name
                    self.knownFor.text = data.knownForDepartment
                    let gender = Gender(rawValue: data.gender ?? 0)
                    self.gender.text = gender?.description
                    self.birthday.text = data.birthday
                    self.placeOfBirth.text = data.placeOfBirth
                } else {
                    self.errorStatus()
                }
            }
        } else {
            errorStatus()
        }
    }
    
    private func setExternalIdButtons() {
        if let castId {
            viewModel?.getPersonExternalIds(personId: castId) { [weak self] data in
                guard let self else {return}
                
                if let imdb = data?.imdbid {
                    self.imdbButton.isHidden = false
                }
                
                if let twitter = data?.twitterid {
                    self.twitterButton.isHidden = false
                }
                
                if let facebook = data?.facebookid {
                    self.facebookButton.isHidden = false
                }
                
                if let instagram = data?.instagramid {
                    self.instagramButton.isHidden = false
                }
            }
        }
    }
    
    private func errorStatus() {
        viewModel?.errorHandlerCompletion?("something went wrong!",.error,.okey) { [weak self] _ in
            guard let self else {return}
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
