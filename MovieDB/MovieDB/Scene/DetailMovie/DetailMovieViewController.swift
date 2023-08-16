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
    var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailMovieViewModel()
        getDetailInfo(movieId: movieId)
        setupBackgroundImageViewWithGradient()
        setOverView()
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
                        self.setDateAndRuntimeLabel(date: date, runtime: runtime)
                    }
                    
                    self.movieName.text = data.title
                    self.scoreIndicatorView.setScore(data.voteAverage ?? 0.0)
                    self.overViewTextView.text = data.overview
                    self.tagLineLabel.text = data.tagline
                    self.voteCountLabel.text = "\(data.voteCount ?? 0) votes"
                    self.createLabelGenres(genres: data.genres)
                    
                } else {
                    self.detailError()
                }
            }
        } else {
            detailError()
        }
    }
    
    func createLabelGenres(genres: [Genre]?) {
        var xPosition: CGFloat = 0.0
        var yPosition: CGFloat = 0.0
        
        let usableSpace = genreView.frame.width
        if let genres {
            for text in genres {
                let label = createGenreNewLabel(text.name ?? "")
                
                if xPosition + label.frame.width > usableSpace {
                    genreViewyConstraint.constant += 30
                    xPosition = 0.0
                    yPosition += label.frame.height + 10.0
                }
                
                label.frame.origin = CGPoint(x: xPosition, y: yPosition)
                
                genreView.addSubview(label)
                
                xPosition += label.frame.width + 2.0
            }
        }
    }
    
    private func createGenreNewLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.font = genreExpampleLabel.font
        label.textAlignment = .center
        label.textColor = genreExpampleLabel.textColor
        label.backgroundColor = genreExpampleLabel.backgroundColor
        label.clipsToBounds = true
        label.layer.cornerRadius = genreExpampleLabel.layer.cornerRadius
        label.layer.borderWidth = genreExpampleLabel.layer.borderWidth
        label.layer.borderColor = genreExpampleLabel.layer.borderColor
        
        label.text = text
        let labelWidth = text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: genreExpampleLabel.font.pointSize)]).width
        label.layer.frame = CGRect(x: 5, y: 5, width: labelWidth + 20 , height: 25)
        
        return label
    }
    private func setDateAndRuntimeLabel(date: String?, runtime: Int?) {
        let dateWidth = (date?.count ?? 0) * 13
        releaseDateLabel.layer.frame = CGRect(x: 0, y: 0, width: dateWidth, height: 25)
        releaseDateLabel.setIcon(iconName: .calendar, colorName: .labelColor, scale: 0.7, startText: nil , andText: date)
        
        let stringRuntime = " \(runtime ?? 0)min"
        let runtimeWidth = stringRuntime.count * 13
        runtimeLabel.layer.frame = CGRect(x: dateWidth + 10, y: 0, width: runtimeWidth, height: 25)
        runtimeLabel.setIcon(iconName: .clock, colorName: .labelColor, scale: 0.7, startText: nil, andText: stringRuntime)
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
    
    private func setOverView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        overViewTextView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        overViewTextView.becomeFirstResponder()
        let symbolConfiguration = UIImage.SymbolConfiguration(scale: .small)
        if !isExpanded {
            let fixedWidth = overViewTextView.frame.size.width
            let newSize = overViewTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            
            if overViewContainerHeightConstraint.constant < newSize.height + 45 {
                overViewContainerHeightConstraint.constant = newSize.height + 45
                overViewArrowButon.setImage(UIImage(systemName: IconeName.arrowChevronUp.rawValue,withConfiguration: symbolConfiguration), for: .normal)
                
            }
        } else {
            overViewContainerHeightConstraint.constant = 100
            overViewArrowButon.setImage(UIImage(systemName: IconeName.arrowChevronDown.rawValue,withConfiguration: symbolConfiguration), for: .normal)
        }
        isExpanded = !isExpanded
    }
    
    private func detailError() {
        let errorMessage = NSLocalizedString("An Error Occurred While Loading Data.", comment: "")
        viewModel?.errorHandlerCompletion?(errorMessage, .error, .okey) { [weak self] _ in
            guard let self else {return}
            self.navigationController?.popViewController(animated: true)
        }
    }
}
