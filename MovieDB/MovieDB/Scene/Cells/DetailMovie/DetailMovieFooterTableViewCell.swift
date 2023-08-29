//
//  DetailMovieFooterTableViewCell.swift
//  MovieDB
//
//  Created by MacBook on 26.08.2023.
//

import UIKit

class DetailMovieFooterTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var trailerCollectionDelegate: TrailerVideoDelegate?
    var castColectionDelegate: CastDelegate?
    var similarCollectionDelegate: SimilarMovieDelegate?
    
    var collections: DetailMovieCollectionModelProtocol?
    var tableViewIndex = 0

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
        
        let similar = String(describing: SimilarCollectionViewCell.self)
        collectionView.register(UINib(nibName: similar, bundle: nil), forCellWithReuseIdentifier: similar)
    }
    
}

//MARK: I transferred the index of the tableView to the footer section so that the collectionView can be used more than once in a single UITableViewCell.

extension DetailMovieFooterTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch tableViewIndex {
        case 2:
            let data = collections as? MovieTrailerModel
            return data?.results?.count ?? 0
        case 3:
            let data = collections as? MovieActorsModel
            return data?.cast?.count ?? 0
        case 4:
            let data = collections as? SimilarMovieModel
            return data?.results?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let emptyCell = UICollectionViewCell()
        
        switch tableViewIndex {
        case 2:
            if let trailers = (collections as? MovieTrailerModel) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TrailerCollectionViewCell.self), for: indexPath) as! TrailerCollectionViewCell
                
                if let url = Constant.RequestPathMovie.trailerThumbnailUrl(key: trailers.results?[indexPath.row].key) {
                    cell.trailerImageView.loadImage(url: url, placeHolderImage: nil) { _, _, _, _ in
                        //stop animation
                    }
                }
                return cell
                
            } else { return emptyCell}
        case 3:
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
        case 4:
            
            if let movies = collections as? SimilarMovieModel {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SimilarCollectionViewCell.self), for: indexPath) as! SimilarCollectionViewCell
                
                let result = movies.results?[indexPath.row]
                
                cell.movieName.text = result?.originalTitle
                cell.movieDate.text = result?.releaseDate
                
                if let imageUrl = Constant.RequestPathMovie.imageUrl(imageSize: .original, path: result?.posterPath) {
                    cell.posterImage.loadImage(url: imageUrl, placeHolderImage: nil) { _, _, _, _ in
                        //animation stop
                    }
                }
                
                return cell
            } else { return emptyCell}
            
        default:
            return UICollectionViewCell()
        }
    }
    
    //MARK: collection cell sizing
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       switch tableViewIndex {
       case 2:
           return CGSize(width: 225, height: 125)
       case 3:
           return CGSize(width: 80, height: 150)
       case 4:
           return CGSize(width: 80, height: 150)
       default:
           return CGSize(width: 80, height: 145)
       }
   }
    
    //MARK: the selected cell delegate is declared
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch tableViewIndex {
        case 2:
            if let trailers = (collections as? MovieTrailerModel) {
                guard let key = trailers.results?[indexPath.row].key else {return}
                trailerCollectionDelegate?.selectedVideo(videoKey: key)
            }
        case 3:
            if let actor = collections as? MovieActorsModel {
                guard let id = actor.cast?[indexPath.row].id else {return}
                castColectionDelegate?.selectedCast(id: id)
            }
        case 4:
            if let similar = collections as? SimilarMovieModel {
                guard let id = similar.results?[indexPath.row].id else {return}
                        similarCollectionDelegate?.selectedMovie(movieId: id)
            }
        default: break
            
        }
    }
}


