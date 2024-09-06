//
//  SearchTableViewCell.swift
//  MovieDB
//
//  Created by MacBook on 8.02.2024.
//

import UIKit

class MovieAndTvShowSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerHeaderView: UIView!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var moreButton: CustomUIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionTitle: UILabel!
    @IBOutlet weak var totalResultsTitle: CustomUILabel!
    
    var toggleSwitch = false
    weak var selectedIndexDelegate: SelectedCellIndexDelegate?
    weak var selectedCollectionDelegate: MovieAndTVShowCollectionDelegate?
    private var modelResults = [MovieAndTVShowsModelResult]()
    private var model: MovieAndTVShowModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        configurationCollectionView()
        setContainerViewTabGesture()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        toggleSwitch = false
        model = nil
        modelResults.removeAll()
        hiddenCollectionSettings()
        loadDataToCell()
    }
    
    func setmodel(data: MovieAndTVShowModel?) {
        if let result = data?.results {
            self.model = data
            self.modelResults = result
            self.loadDataToCell()
        }
        
    }
    
    private func loadDataToCell() {
        collectionTitle.text = model?.collectionTitle
        totalResultsTitle.text = " \(model?.totalResults ?? 0) "
    }

    private func configurationCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let cellString = String(describing: MovieAndTVShowCollectionViewCell.self)
        collectionView.register(UINib(nibName: cellString, bundle: nil), forCellWithReuseIdentifier: cellString)
    }
    
    func setContainerViewTabGesture(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(containerViewControl))
        containerHeaderView.addGestureRecognizer(gestureRecognizer)
    }
    
    @IBAction func moreButtonTapped(_ sender: Any) {
        guard let model else {return}
        selectedCollectionDelegate?.allButtonOperation(data: model)
    }
    
    //ContainerView hide control
    @objc func containerViewControl() {
        guard !modelResults.isEmpty else{return}
        
        if !toggleSwitch {
            notHiddenCollectionSettings()
        } else {
            hiddenCollectionSettings()
        }
        
        //TableView layout update
        if let tableView = self.superview as? UITableView {
            CustomUIViewContainer.animate(withDuration: 0.33) {
                tableView.setNeedsLayout()
                tableView.layoutIfNeeded()
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        
        toggleSwitch = !toggleSwitch
    }
    
    private func hiddenCollectionSettings() {
        let symbolConfiguration = UIImage.SymbolConfiguration(scale: .small)
        collectionView.isHidden = true
        moreButton.isHidden = true
        
        toggleButton.setImage(UIImage(systemName: IconName.arrowChevronDown.rawValue, withConfiguration: symbolConfiguration), for: .normal)
    }
    
    private func notHiddenCollectionSettings() {
        let symbolConfiguration = UIImage.SymbolConfiguration(scale: .small)
        collectionView.isHidden = false
        if model?.totalResults ?? 0 > modelResults.count {
            moreButton.isHidden = false
        }
        
        toggleButton.setImage(UIImage(systemName: IconName.arrowChevronUp.rawValue,withConfiguration: symbolConfiguration), for: .normal)
    }
    
    
   
}

extension MovieAndTvShowSearchTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieAndTVShowCollectionViewCell.self), for: indexPath) as! MovieAndTVShowCollectionViewCell
        let data = modelResults[indexPath.row]
        cell.loadCell(model: data)
        
        if let path = data.posterPath, let url = Constant.RequestPathMovie.imageUrl(imageSize: .w500, path: path) {
            cell.posterImage.loadImage(url: url, placeHolderImage: nil) { _, _, _, _ in
                //animation stop
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = modelResults[indexPath.row].id {
            switch model?.mediaType {
            case .movie:
                selectedIndexDelegate?.selectedIdMovie(id: id)
            case .tv:
                selectedIndexDelegate?.selectedIdTvShow(id: id)
            case nil: break
            }
        }
    }
}
    

