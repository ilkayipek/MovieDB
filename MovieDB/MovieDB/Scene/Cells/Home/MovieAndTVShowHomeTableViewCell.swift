//
//  MovieCollectionTableViewCell.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

import UIKit

class MovieAndTVShowHomeTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionTitle: UILabel!
    
    weak var selectedIndexDelegate: SelectedIndexDelegate?
    var model = [MovieAndTVShowsModelResult]()
    var mediaType: MediaType!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
        
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let collectionCellString = String(describing: MovieAndTVShowCollectionViewCell.self)
        collectionView.register(UINib(nibName: collectionCellString, bundle: nil), forCellWithReuseIdentifier: collectionCellString)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

extension MovieAndTVShowHomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieAndTVShowCollectionViewCell.self), for: indexPath) as! MovieAndTVShowCollectionViewCell
        
        cell.loadCell(model: model[indexPath.row])
        
        if let imagePath = model[indexPath.row].posterPath {
            if let url = Constant.RequestPathMovie.imageUrl(imageSize: .original, path: imagePath) {
                cell.posterImage.loadImage(url: url, placeHolderImage: nil){ _, _, _, _  in
                    cell.posterIndicator.stopAnimating()
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = model[indexPath.row].id {
            selectedIndexDelegate?.selectedId(movieId: id, mediaType: mediaType)
        }
    }
}
