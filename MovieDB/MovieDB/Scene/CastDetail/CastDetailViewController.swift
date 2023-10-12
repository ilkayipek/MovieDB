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
    @IBOutlet weak var knownForLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    @IBOutlet weak var biographyContainerView: CustomContainerUIView!
    @IBOutlet weak var biographyContainterHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imdbButton: CustomUIButton!
    @IBOutlet weak var facebookButton: CustomUIButton!
    @IBOutlet weak var twitterButton: CustomUIButton!
    @IBOutlet weak var instagramButton: CustomUIButton!
    @IBOutlet weak var webButton: CustomUIButton!
    @IBOutlet weak var webVerticalLineView: UIView!
    @IBOutlet weak var profilesCollectionView: UICollectionView!
    @IBOutlet weak var biographyArrowButton: UIButton!
    
    
    var profiles = [Profile]()
    var castId: Int?
    var isExpanded = false
    var castImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CastDetailViewModel()
        setDetailInfos()
        setExternalIdButtons()
        configureCollectionView()
        setPersonImages()
        
    }
    
    private func setBiographyHeight() {
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(touchedBiography))
        biographyContainerView.addGestureRecognizer(tabGesture)
        
    }
    
    //row count control and row count setting when clicked
    @objc func touchedBiography() {
        var currentNumberOfLines = biographyLabel.numberOfLinesRequired()
        let symbolConfiguration = UIImage.SymbolConfiguration(scale: .small)
        
        if currentNumberOfLines != 3 {
            if !isExpanded {
                biographyLabel.numberOfLines = 0
                biographyArrowButton.setImage(UIImage(systemName: IconeName.arrowChevronUp.rawValue,withConfiguration: symbolConfiguration), for: .normal)
            } else {
                biographyLabel.numberOfLines = 3
                biographyArrowButton.setImage(UIImage(systemName: IconeName.arrowChevronDown.rawValue,withConfiguration: symbolConfiguration), for: .normal)
            }
            isExpanded = !isExpanded
        }
        
    }
    
    private func setPersonImages() {
        viewModel?.getPersonImages(personId: castId ?? 0) { [weak self] data in
            guard let self else {return}
            guard let profiles = data?.profiles else {return}
            self.profiles = profiles
            self.profilesCollectionView.reloadData()
        }
    }
    
    private func configureCollectionView() {
        profilesCollectionView.delegate = self
        profilesCollectionView.dataSource = self
        
        let profilesCellString = String(describing: CastProfilesCollectionViewCell.self)
        profilesCollectionView.register(UINib(nibName: profilesCellString, bundle: nil), forCellWithReuseIdentifier: profilesCellString)
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
                        self.biographyLabel.text = data.biography
                        self.setBiographyHeight()
                    }
                    
                    self.nameLabel.text = data.name
                    self.knownForLabel.text = data.knownForDepartment
                    let gender = Gender(rawValue: data.gender ?? 0)
                    self.genderLabel.text = gender?.description
                    self.birthdayLabel.text = data.birthday
                    self.placeOfBirthLabel.text = data.placeOfBirth
                } else {
                    self.errorStatus()
                }
            }
        } else {
            errorStatus()
        }
    }
    
    //Social media buttons were made visible according to incoming data
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

extension CastDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = profilesCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CastProfilesCollectionViewCell.self), for: indexPath) as! CastProfilesCollectionViewCell
        
        //downloaded images append in castImages
        if let url = Constant.RequestPathMovie.imageUrl(imageSize: .original, path: profiles[indexPath.row].filePath) {
            cell.profileImage.loadImage(url: url, placeHolderImage: nil) { [weak self] (image, _, _, _) in
                guard let self else {return}
                guard let image else {return}
                if !castImages.contains(image) {
                    castImages.append(image)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)
   }
    
    //selected image index and castImages transferred to FullScreenViewController.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let targetVc = FullScreenPhotoPageViewController()
        targetVc.images = castImages
        targetVc.selectedImageIndex = indexPath.row
        self.navigationController?.pushViewController(targetVc, animated: true)
    }
}
