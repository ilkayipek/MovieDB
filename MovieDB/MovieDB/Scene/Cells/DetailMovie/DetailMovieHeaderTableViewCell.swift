//
//  DetailMovieHeaderTableViewCell.swift
//  MovieDB
//
//  Created by MacBook on 26.08.2023.
//

import UIKit

class DetailMovieHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var loadSpinner: UIActivityIndicatorView!
    @IBOutlet weak var posterImage: CustomUIImageView!
    @IBOutlet weak var favoriteButton: CustomUIButton!
    @IBOutlet weak var watchListButton: CustomUIButton!
    @IBOutlet weak var starButton: CustomUIButton!
    @IBOutlet weak var runtimeLabel: CustomUILabel!
    @IBOutlet weak var releaseDateLabel: CustomUILabel!
    @IBOutlet weak var genreExpampleLabel: CustomUILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var genreView: UIView!
    @IBOutlet weak var genreViewyConstraint: NSLayoutConstraint!
    @IBOutlet weak var scoreIndicatorView: ScoreIndicatorView!
    
    var detailMovieModel: DetailMovieModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLoadContent()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setLoadContent() {
        guard let detailMovieModel else {return}
        
        let posterUrl = Constant.RequestPathMovie.imageUrl(imageSize: .original, path: detailMovieModel.posterPath)
        
        if posterUrl != nil {
            self.posterImage.loadImage(url: posterUrl!, placeHolderImage: nil) { _, _, _, _ in
                self.posterImage.isHidden = false
                self.loadSpinner.stopAnimating()
            }
        }
        
        if let date = detailMovieModel.releaseDate, let runtime = detailMovieModel.runtime {
            runtimeLabel.isHidden = false
            releaseDateLabel.isHidden = false
            setDateAndRuntimeLabel(date: date, runtime: runtime )
        }
        
        movieName.text = detailMovieModel.title
        tagLineLabel.text = detailMovieModel.tagline
        voteCountLabel.text = "\(detailMovieModel.voteCount ?? 0) votes"
        scoreIndicatorView.setScore(detailMovieModel.voteAverage ?? 0.0)
        createLabelGenres(genres: detailMovieModel.genres)
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
    
    func createGenreNewLabel(_ text: String) -> UILabel {
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
    
    func setDateAndRuntimeLabel(date: String?, runtime: Int?) {
        let dateWidth = (date?.count ?? 0) * 13
        let labelWidth = date?.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: genreExpampleLabel.font.pointSize)]).width
        releaseDateLabel.layer.frame = CGRect(x: 0, y: 0, width: dateWidth, height: 25)
        releaseDateLabel.setIcon(iconName: .calendar, colorName: .labelColor, scale: 0.7, startText: nil , andText: date)
        
        let stringRuntime = " \(runtime ?? 0)min"
        let runtimeWidth = stringRuntime.count * 13
        runtimeLabel.layer.frame = CGRect(x: dateWidth + 10, y: 0, width: runtimeWidth, height: 25)
        runtimeLabel.setIcon(iconName: .clock, colorName: .labelColor, scale: 0.7, startText: nil, andText: stringRuntime)
    }
}
