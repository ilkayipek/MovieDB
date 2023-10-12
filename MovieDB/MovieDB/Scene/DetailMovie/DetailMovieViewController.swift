//
//  DetailMovieViewController.swift
//  MovieDB
//
//  Created by MacBook on 15.08.2023.
//

import UIKit

class DetailMovieViewController: BaseViewController<DetailMovieViewModel> {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundPoster: UIImageView!
    
    var movieId: Int?
    var footerModel = [(order: Int,data: DetailMovieCollectionModelProtocol?)]()
    var detailMovieModel: DetailMovieModel?
    var reviewsModel: ReviewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailMovieViewModel()
        getDetailInfo(movieId: movieId)
        setupBackgroundImageViewWithGradient()
        configureTableView()
        getOtherList()
    }
    
    private func getOtherList() {
        
        viewModel?.getReviewsMovie(movieId: movieId ?? 0 ) { [weak self] (data) in
            guard let self else {return}
            
            self.reviewsModel = data
        }
        
        
        viewModel?.getTrailers(movieId: movieId ?? 0) { [weak self] (data) in
            guard let self else {return}
            
            var result = data
            result?.collectionTitle = NSLocalizedString("Trailers", comment: "")
            self.footerModel.append((0,result))
        }
        
        
        viewModel?.getActors(movieId: movieId ?? 0) { [weak self] (data) in
            guard let self else {return}
            
            var result = data
            result?.collectionTitle = NSLocalizedString("Actors", comment: "")
            self.footerModel.append((1,result))
        }
        
        
        viewModel?.getSimilarMovie(movieId: movieId ?? 0) { [weak self] (data) in
            guard let self else {return}
            
            var result = data
            result?.collectionTitle = NSLocalizedString("Similar Movies", comment: "")
            self.footerModel.append((2,result))
            
            
        }
        
        viewModel?.closeDispatchGroup { [weak self] in
            guard let self else {return}
            
            self.footerModel.sort(by: { $0.order < $1.order })
            self.tableView.reloadData()
        }
        
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let headerString = String(describing: DetailMovieHeaderTableViewCell.self)
        tableView.register(UINib(nibName: headerString, bundle: nil), forCellReuseIdentifier: headerString)
        
        let contentString = String(describing: DetailMovieContentTableViewCell.self)
        tableView.register(UINib(nibName: contentString, bundle: nil), forCellReuseIdentifier: contentString)
        
        let footerString = String(describing: DetailMovieFooterTableViewCell.self)
        tableView.register(UINib(nibName: footerString, bundle: nil), forCellReuseIdentifier: footerString)
        
    }
    
    private func getDetailInfo(movieId: Int?) {
        if movieId != nil {
            viewModel?.getMovieDetailOriginal(movieId: movieId!) {[weak self] (data) in
                guard let self else {return}
                if let data {
                    self.detailMovieModel = data
                    
                    let defaultImage = UIImage(named: "default")
                    let backgroundPosterUrl = Constant.RequestPathMovie.imageUrl(imageSize: .original, path: data.backdropPath)
                    if backgroundPosterUrl != nil {
                        self.backgroundPoster.loadImage(url: backgroundPosterUrl!, placeHolderImage: defaultImage, nil)
                    }
                    
                    self.tableView.reloadData()
                } else {
                    self.detailError()
                }
            }
        } else {
            detailError()
        }
    }
    
    private func setupBackgroundImageViewWithGradient() {
        backgroundPoster.clipsToBounds = true
        
        let gradientLayer = createVerticalGradientLayer()
        backgroundPoster.layer.addSublayer(gradientLayer)
    }
    
    private func createVerticalGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        
        let aspectRatio = backgroundPoster.bounds.width / backgroundPoster.bounds.height
        print(aspectRatio)
        
        gradientLayer.colors = [UIColor.clear.cgColor, view.backgroundColor?.cgColor ?? UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: aspectRatio)
        gradientLayer.frame = CGRect(x: 0, y: 0 , width: 500, height: view.frame.height * aspectRatio )
        return gradientLayer
    }
    
    private func detailError() {
        let errorMessage = NSLocalizedString("An Error Occurred While Loading Data.", comment: "")
        viewModel?.errorHandlerCompletion?(errorMessage, .error, .okey) { [weak self] _ in
            guard let self else {return}
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: Segmentation on stage using tableView
extension DetailMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return footerModel.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailMovieHeaderTableViewCell.self), for: indexPath) as! DetailMovieHeaderTableViewCell
            cell.detailMovieModel = detailMovieModel
            cell.setLoadContent()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailMovieContentTableViewCell.self), for: indexPath) as! DetailMovieContentTableViewCell
            cell.overViewLabel.text = detailMovieModel?.overview
            cell.reviewsModel = reviewsModel
            cell.setReviews()
            return cell
        case 2,3,4:
            
            let (_ ,data) = footerModel[indexPath.row - 2]
            if data != nil {
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailMovieFooterTableViewCell.self), for: indexPath) as! DetailMovieFooterTableViewCell
                
                cell.trailerCollectionDelegate = self
                cell.castColectionDelegate = self
                cell.similarCollectionDelegate = self
                
                cell.tableViewIndex = indexPath.row
                
                
                cell.collections = data
                cell.collectionTitle.text = data?.collectionTitle
                
                cell.collectionView.reloadData()
                return cell
            } else {
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0,1:
            return UITableView.automaticDimension
        case 2, 3, 4:
            let (_, data) = footerModel[indexPath.row - 2]
            if data != nil {
                return UITableView.automaticDimension
            } else {
                return 0
            }
        default:
            return 0
        }
    }
}

// MARK: Selected cells are processed with the help of delegate.
extension DetailMovieViewController: TrailerVideoDelegate, CastDelegate, SimilarMovieDelegate {
    func selectedMovie(movieId: Int) {
        let targetVc = DetailMovieViewController.loadFromNib()
        targetVc.movieId = movieId
        self.navigationController?.pushViewController(targetVc, animated: true)
    }
    
    func selectedCast(id: Int) {
        let targetVc = CastDetailViewController.loadFromNib()
        targetVc.castId = id
        self.navigationController?.pushViewController(targetVc, animated: true)
    }
    
    func selectedVideo(videoKey: String) {
        let youtubeAppURLString = Constant.RequestPathMovie.trailerVideoUrlApp(key: videoKey)
        
        if let youtubeAppURL = URL(string: youtubeAppURLString), UIApplication.shared.canOpenURL(youtubeAppURL) {
            UIApplication.shared.open(youtubeAppURL, options: [:], completionHandler: nil)
        } else  {
            let targetVc = TrailerWebViewViewController.loadFromNib()
            targetVc.videoKey = videoKey
            self.navigationController?.pushViewController(targetVc, animated: true)
        }
    }
    
}

