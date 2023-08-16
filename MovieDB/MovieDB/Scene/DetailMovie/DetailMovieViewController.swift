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
        setupBackgroundImageViewWithGradient()
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
