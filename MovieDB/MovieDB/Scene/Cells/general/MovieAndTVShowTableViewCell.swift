//
//  MovieAndTVShowTableViewCell.swift
//  MovieDB
//
//  Created by MacBook on 22.12.2023.
//

import UIKit

class MovieAndTVShowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerHeaderView: UIView!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var allButton: CustomUIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionTitle: UILabel!
    
    var toggleSwitch = false
    weak var selectedIndexDelegate: SelectedIndexDelegate?
    var model = [MovieAndTVShowsModelResult]()

    override func awakeFromNib() {
        super.awakeFromNib()
        configurationCollectionView()
        setContainerViewTabGesture()
    }

    private func configurationCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let cellString = String(describing: MovieAndTVShowCollectionViewCell.self)
        collectionView.register(UINib(nibName: cellString, bundle: nil), forCellWithReuseIdentifier: cellString)
    }
    
    func setContainerViewTabGesture(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(containerViewControl))
        containerHeaderView.addGestureRecognizer(gestureRecognizer)
    }
    
    //ContainerView hide control
    @objc func containerViewControl() {
        guard !model.isEmpty else{return}
        let symbolConfiguration = UIImage.SymbolConfiguration(scale: .small)
        
        if !toggleSwitch {
            collectionView.isHidden = false
            allButton.isHidden = false
            
            toggleButton.setImage(UIImage(systemName: IconName.arrowChevronUp.rawValue,withConfiguration: symbolConfiguration), for: .normal)
        } else {
            collectionView.isHidden = true
            allButton.isHidden = true
            
            toggleButton.setImage(UIImage(systemName: IconName.arrowChevronDown.rawValue, withConfiguration: symbolConfiguration), for: .normal)
            
        }
        
        //TableView layout update
        if let tableView = self.superview as? UITableView {
            CustomUIViewContainer.animate(withDuration: 0.33) {
                tableView.setNeedsLayout()
                tableView.layoutIfNeeded()
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        
        toggleSwitch = !toggleSwitch
    }
   
}

extension MovieAndTVShowTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieAndTVShowCollectionViewCell.self), for: indexPath) as! MovieAndTVShowCollectionViewCell
        let data = model[indexPath.row]
        cell.name.text = data.title
        cell.date.text = data.releaseDate
        
        if let path = data.posterPath, let url = Constant.RequestPathMovie.imageUrl(imageSize: .w500, path: path) {
            cell.posterImage.loadImage(url: url, placeHolderImage: nil) { _, _, _, _ in
                //animation stop
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = model[indexPath.row].id {
            selectedIndexDelegate?.selectedId(movieId: id, mediaType: .movie)
        }
    }
    
    
}
