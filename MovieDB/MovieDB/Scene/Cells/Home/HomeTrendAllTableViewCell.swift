//
//  HomeTrendAllTableViewCell.swift
//  MovieDB
//
//  Created by MacBook on 19.10.2023.
//

import UIKit

class HomeTrendAllTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var backgroungImage: UIImageView!
    
    var selectedIndexDelegate: SelectedIndexDelegate?
    
    var models = [[MovieAndTVShowsModelResult]?]()
    var currentModel: [MovieAndTVShowsModelResult]?
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
        cellBackgroundImageLoad()
        loadSegmentControl()
        createShadow()
    }

    //MARK: Update current Models based on selected segment
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex
        switch selectedSegmentIndex {
        case 0:
            if let model = models[selectedSegmentIndex] {
                currentModel = model
                collectionView.reloadData()
            } else {
                sender.selectedSegmentIndex = 1
            }
        case 1:
            if let model = models[selectedSegmentIndex] {
                currentModel = model
                collectionView.reloadData()
            } else {
                sender.selectedSegmentIndex = 0
            }
        default:
            currentModel = nil
            collectionView.reloadData()
        }
    }
    
    //MARK: segmentControl text set color
    func loadSegmentControl() {
        let customDefaut = UIColor(named: "ContentTextColor")
        let customSelected = UIColor(named: "DetailButtonContentColor")
        
        let attributesDefault: [NSAttributedString.Key: Any] = [
            .foregroundColor: customDefaut ?? UIColor.gray
        ]
        
        let attributesSelected: [NSAttributedString.Key: Any] = [
            .foregroundColor: customSelected ?? UIColor.blue
        ]
        
        segmentController.setTitleTextAttributes(attributesDefault, for: .normal)
        segmentController.setTitleTextAttributes(attributesSelected, for: .selected)
    }
    
    //MARK: Load background image
    func cellBackgroundImageLoad() {
        guard let modelCount = currentModel?.count else {return}
        let randomNumber = Int.random(in: 0...modelCount - 1)
        if let model = currentModel, !model.isEmpty {
            guard let url = Constant.RequestPathMovie.imageUrl(imageSize: .original, path: currentModel?[randomNumber].backdropPath) else {return}
                backgroungImage.loadImage(url: url, placeHolderImage: nil, nil)
        }
    }
    
    //MARK: Cell background image bottom and top border set shadow
    private func createShadow()  {
        let gradientLayer = CAGradientLayer()
        let backgrountColor = UIColor(named: "BackgroundColor")?.cgColor ?? UIColor.black.cgColor
        gradientLayer.frame = backgroungImage.bounds
        gradientLayer.colors = [backgrountColor, UIColor.clear.cgColor, UIColor.clear.cgColor, backgrountColor]
        gradientLayer.locations = [0.0, 0.5, 0.5, 0.9]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        backgroungImage.layer.borderWidth = 0
        backgroungImage.layer.borderColor = UIColor.clear.cgColor
        backgroungImage.layer.addSublayer(gradientLayer)
    }

    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let cellString = String(describing: MovieAndTVShowCollectionViewCell.self)
        collectionView.register(UINib(nibName: cellString, bundle: nil), forCellWithReuseIdentifier:    cellString)
    }
}

extension HomeTrendAllTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieAndTVShowCollectionViewCell.self), for: indexPath) as! MovieAndTVShowCollectionViewCell
        if let currentModel = currentModel?[indexPath.row] {
            cell.loadCell(model: currentModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = currentModel?[indexPath.row].id {
            selectedIndexDelegate?.selectedId(movieId: id)
        }
    }
    
    
}
