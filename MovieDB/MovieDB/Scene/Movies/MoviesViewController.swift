//
//  MoviesViewController.swift
//  MovieDB
//
//  Created by MacBook on 7.12.2023.
//

import UIKit

class MoviesViewController: BaseViewController<MoviesViewModel> {
    @IBOutlet weak var collectionListTableView: UITableView!
    var movieCollectionsData = [MovieAndTVShowModel?]()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MoviesViewModel()
        collectionListTableViewConfigure()
        getMovieCollections()
    }
    
    //fetching movies
    func getMovieCollections() {
        viewModel?.fetchNowPlaying{ [weak self] data in
            guard let self else {return}
            self.movieCollectionsData.append(data)
            self.collectionListTableView.reloadData()
        }
        
        viewModel?.fetchPopular{ [weak self] data in
            guard let self else {return}
            self.movieCollectionsData.append(data)
            self.collectionListTableView.reloadData()
        }
        
        viewModel?.fetchTopRated{ [weak self] data in
            guard let self else {return}
            self.movieCollectionsData.append(data)
            self.collectionListTableView.reloadData()
        }
        
        viewModel?.fetchUpcoming{ [weak self] data in
            guard let self else {return}
            self.movieCollectionsData.append(data)
            self.collectionListTableView.reloadData()
        }
    }
    
    func collectionListTableViewConfigure() {
        collectionListTableView.delegate = self
        collectionListTableView.dataSource = self
        
        var cellString = String(describing: TrendAllTableViewCell.self)
        collectionListTableView.register(UINib(nibName: cellString, bundle: nil), forCellReuseIdentifier: cellString)
        
        cellString = String(describing: MovieAndTVShowTableViewCell.self)
        collectionListTableView.register(UINib(nibName: cellString, bundle: nil), forCellReuseIdentifier: cellString)
        
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCollectionsData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionListTableView.dequeueReusableCell(withIdentifier: String(describing: TrendAllTableViewCell.self), for: indexPath) as! TrendAllTableViewCell
            cell.collectionTitle.text = "Trending"
            return cell
            
        case 1,2,3,4:
            let cell = collectionListTableView.dequeueReusableCell(withIdentifier: String(describing: MovieAndTVShowTableViewCell.self), for: indexPath) as! MovieAndTVShowTableViewCell
            
            let data = movieCollectionsData[indexPath.row - 1]
            cell.collectionTitle.text = data?.collectionTitle
            
            if let result = data?.results {
                cell.model = result
            }
            cell.collectionView.reloadData()
            return cell
            
            
        default:
            return UITableViewCell()
        }
        
    }
    
    
}

