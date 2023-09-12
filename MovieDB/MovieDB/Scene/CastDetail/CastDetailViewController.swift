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
    @IBOutlet weak var profilesCollectionView: UICollectionView!
    
    var images = [Profile]()
    var castId: Int?
    var isExpanded = false
    
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
    
    @objc func touchedBiography() {
        biography.becomeFirstResponder()
        if !isExpanded {
            let heightOutsideOverView = biographyContainterHeightConstraint.constant - biography.frame.size.height
            let fixedWidth = biography.frame.size.width
            let overViewNewSize = biography.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newHeightContainer = overViewNewSize.height + heightOutsideOverView
            print("yeni yükseklikk: \(newHeightContainer)")
            
            if biographyContainterHeightConstraint.constant < newHeightContainer {
                biographyContainterHeightConstraint.constant = newHeightContainer
                
                //biographyArrowButon.setImage(UIImage(systemName: IconeName.arrowChevronUp.rawValue,withConfiguration: symbolConfiguration), for: .normal)
            }
        } else {
            biographyContainterHeightConstraint.constant = 100
            
            //biographyArrowButon.setImage(UIImage(systemName: IconeName.arrowChevronDown.rawValue,withConfiguration: symbolConfiguration), for: .normal)
        }
        isExpanded = !isExpanded
        
    }
    
    private func setPersonImages() {
        viewModel?.getPersonImages(personId: castId ?? 0) { [weak self] data in
            guard let self else {return}
            guard let profiles = data?.profiles else {return}
            images = profiles
            profilesCollectionView.reloadData()
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
                        self.biography.text = data.biography
                        self.setBiographyHeight()
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

extension CastDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = profilesCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CastProfilesCollectionViewCell.self), for: indexPath) as! CastProfilesCollectionViewCell
        
        if let url = Constant.RequestPathMovie.imageUrl(imageSize: .w200, path: images[indexPath.row].filePath) {
            cell.profileImage.loadImage(url: url, placeHolderImage: nil) { _, _, _, _ in
                // stop animation
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)
   }
}
