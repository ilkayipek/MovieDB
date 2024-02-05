//
//  AllListCollectionViewController.swift
//  MovieDB
//
//  Created by MacBook on 26.01.2024.
//

import UIKit

class AllListCollectionViewController: BaseViewController<AllListCollectionViewModel> {
    @IBOutlet weak var allListCollectionView: UICollectionView!
    private var mediaType: MediaType!
    private var collection: MovieCollections!
    private var model = [MovieAndTVShowsModelResult]()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AllListCollectionViewModel()
        configureAllListCollectionView()
        getList()
    }
    
    func setData(mediaType: MediaType, collection: MovieCollections) {
        self.mediaType = mediaType
        self.collection = collection
        self.title = collection.rawValue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.ContentTextColor,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25.0)
        ]
    }
    
    func configureAllListCollectionView() {
        allListCollectionView.delegate = self
        allListCollectionView.dataSource = self
        
        let cellString = String(describing: MovieAndTVShowCollectionViewCell.self)
        allListCollectionView.register(UINib(nibName: cellString, bundle: nil), forCellWithReuseIdentifier: cellString)
    }
    
    func getList() {
        switch mediaType {
        case .movie:
            viewModel?.fetchAllMoviePageResults(collection: collection) { [weak self] result in
                guard let self else {return}
                guard let result else {return}
                
                self.model = result
                self.allListCollectionView.reloadData()
            }
        case .tv: break
            //tv
        case .none:
            break
        }
    }
    
}

extension AllListCollectionViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = allListCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieAndTVShowCollectionViewCell.self), for: indexPath) as! MovieAndTVShowCollectionViewCell
        guard !model.isEmpty else {return cell}
        
        cell.loadCell(model: model[indexPath.row])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (model.count - 8) {
         getList()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch mediaType {
        case .movie:
            let targetVc = DetailMovieViewController.loadFromNib()
            targetVc.movieId = model[indexPath.row].id
            self.navigationController?.pushViewController(targetVc, animated: true)
        case .tv: break
            
        case .none:
            break
        }
    }
    
    
}
