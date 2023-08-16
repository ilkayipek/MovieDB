//
//  DetailMovieViewController.swift
//  MovieDB
//
//  Created by MacBook on 15.08.2023.
//

import UIKit

class DetailMovieViewController: BaseViewController<DetailMovieViewModel> {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadSpinner: UIActivityIndicatorView!
    @IBOutlet weak var backgroundPoster: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var watchListButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var overViewArrowButon: UIButton!
    @IBOutlet weak var runtimeLabel: CustomUILabel!
    @IBOutlet weak var releaseDateLabel: CustomUILabel!
    @IBOutlet weak var genreExpampleLabel: CustomUILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var overViewTextView: UITextView!
    @IBOutlet weak var genreView: UIView!
    @IBOutlet weak var genreViewyConstraint: NSLayoutConstraint!
    @IBOutlet weak var overViewContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scoreIndicatorView: ScoreIndicatorView!
    
    var movieId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailMovieViewModel()
        getDetailInfo(movieId: movieId)
        setupBackgroundImageViewWithGradient()
    }
    
    private func getDetailInfo(movieId: Int?) {
        if movieId != nil {
            viewModel?.getMovieDetailOriginal(movieId: movieId!) {[weak self] (data) in
                guard let self else {return}
                if let data {
                    let defaultImage = UIImage(named: "default")
                    let backgroundPosterUrl = Constant.RequestPathMovie.imageUrl(imageSize: .original, path: data.backdropPath)
                    let posterUrl = Constant.RequestPathMovie.imageUrl(imageSize: .original, path: data.posterPath)
                    
                    if backgroundPosterUrl != nil {
                        self.backgroundPoster.loadImage(url: backgroundPosterUrl!, placeHolderImage: defaultImage, nil)
                    }
                    
                    if posterUrl != nil {
                        self.posterImage.loadImage(url: posterUrl!, placeHolderImage: nil) { _, _, _, _ in
                            self.posterImage.isHidden = false
                            self.loadSpinner.stopAnimating()
                        }
                    }
                    
                    if let date = data.releaseDate, let runtime = data.runtime {
                        self.runtimeLabel.isHidden = false
                        self.releaseDateLabel.isHidden = false
                    }
                    
                    self.movieName.text = data.title
                    self.scoreIndicatorView.setScore(data.voteAverage ?? 0.0)
                    self.overViewTextView.text = data.overview
                    self.tagLineLabel.text = data.tagline
                    self.voteCountLabel.text = "\(data.voteCount ?? 0) votes"
                    
                } else {
                    print("ERROR")
                }
            }
        } else {
            print("ERROR")
        }
    }
    
    private func setupBackgroundImageViewWithGradient() {
        backgroundPoster.clipsToBounds = true
        
        let gradientLayer = createVerticalGradientLayer()
        backgroundPoster.layer.addSublayer(gradientLayer)
    }
    
    private func createVerticalGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [UIColor.clear.cgColor, view.backgroundColor?.cgColor ?? UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.7)
        gradientLayer.frame = CGRect(x: 0, y: 0.25 , width: view.frame.width, height: view.frame.height * 0.4 )
        return gradientLayer
    }
}
