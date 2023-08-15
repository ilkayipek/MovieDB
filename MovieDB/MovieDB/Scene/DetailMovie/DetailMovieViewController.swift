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
    @IBOutlet weak var overViewTextView: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var watchListButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var genreExpampleLabel: UILabel!
    @IBOutlet weak var genreView: UIView!
    @IBOutlet weak var genreViewyConstraint: NSLayoutConstraint!
    @IBOutlet weak var overViewContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scoreIndicatorView: ScoreIndicatorView!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var overViewArrowButon: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailMovieViewModel()
    }
}
