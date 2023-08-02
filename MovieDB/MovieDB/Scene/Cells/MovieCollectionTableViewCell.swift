//
//  MovieCollectionTableViewCell.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

import UIKit

class MovieCollectionTableViewCell: UITableViewCell {
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    @IBOutlet weak var collectionTitle: UILabel!
    
    var model: [MovieResult]?

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
        
    }
    
    private func configureCollectionView() {
        movieListCollectionView.delegate = self
        movieListCollectionView.dataSource = self
        
        let collectionCellString = String(describing: MovieListCollectionViewCell.self)
        movieListCollectionView.register(UINib(nibName: collectionCellString, bundle: nil), forCellWithReuseIdentifier: collectionCellString)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

extension MovieCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieListCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieListCollectionViewCell.self), for: indexPath) as! MovieListCollectionViewCell
        guard let model else {return cell}
        
        cell.movieName.text = model[indexPath.row].title
        cell.movieDate.text = model[indexPath.row].releaseDate
        
        if let imagePath = model[indexPath.row].posterPath {
            if let url = Constant.RequestPathMovie.imageUrl(imageSize: .original, path: imagePath) {
                cell.posterImage.loadImage(url: url, placeHolderImage: nil){ _, _, _, _  in
                    cell.posterIndicator.stopAnimating()
                }
            }
        }
        return cell
    }
}
