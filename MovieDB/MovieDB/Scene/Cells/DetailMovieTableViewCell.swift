//
//  DetailMovieTableViewCell.swift
//  MovieDB
//
//  Created by MacBook on 17.08.2023.
//

import UIKit

class DetailMovieTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionViewTiltleLabel: UILabel!
    @IBOutlet weak var  collectionView: UICollectionView!
    
    var trailerCollectionDelegate: TrailerVideoDelegate?
    
    var collections: DetailMovieCollectionModelProtocol?
    var tableViewIndex: Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let actors = String(describing: ActorsCollectionViewCell.self)
        collectionView.register(UINib(nibName: actors, bundle: nil), forCellWithReuseIdentifier: actors)
        
        let trailer = String(describing: TrailerCollectionViewCell.self)
        collectionView.register(UINib(nibName: trailer, bundle: nil), forCellWithReuseIdentifier: trailer)
    }
    
}

extension DetailMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch tableViewIndex {
        case 0:
            let data = collections as! MovieTrailerModel
            return data.results?.count ?? 0
        case 1:
            let data = collections as! MovieActorsModel
            return data.cast?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let emptyCell = UICollectionViewCell()
        
        switch tableViewIndex {
        case 0:
            if let trailers = (collections as? MovieTrailerModel) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TrailerCollectionViewCell.self), for: indexPath) as! TrailerCollectionViewCell
                
                if let url = Constant.RequestPathMovie.trailerThumbnailUrl(key: trailers.results?[indexPath.row].key) {
                    cell.trailerImageView.loadImage(url: url, placeHolderImage: nil) { _, _, _, _ in
                        //stop animation
                    }
                }
                return cell
                
            } else { return emptyCell}
        case 1:
            if let actors = collections as? MovieActorsModel {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ActorsCollectionViewCell.self), for: indexPath) as! ActorsCollectionViewCell
                
                
                cell.actorNameLabel.text = actors.cast?[indexPath.row].originalName
                cell.actorDepartment.text = actors.cast?[indexPath.row].knownForDepartment
                
                if let imageUrl = Constant.RequestPathMovie.imageUrl(imageSize: .original, path: actors.cast?[indexPath.row].profilePath) {
                    cell.actorImageView.loadImage(url: imageUrl, placeHolderImage: nil) { _, _, _, _ in
                        //animation stop
                    }
                }
                return cell
            }  else { return emptyCell}
        default:
            return UICollectionViewCell()
        }
    }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch tableViewIndex {
        case 0:
            return CGSize(width: 225, height: 125)
        case 1:
            return CGSize(width: 80, height: 145)
        default:
            return CGSize(width: 80, height: 145)
        }
    }
    
    //MARK: the selected cell delegate is declared
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch tableViewIndex {
        case 0:
            if let trailers = (collections as? MovieTrailerModel) {
                guard let key = trailers.results?[indexPath.row].key else {return}
                trailerCollectionDelegate?.selectedVideo(videoKey: key)
            }
        case 1: break
            //Cast Delegate
        default: break
            
        }
    }

}

