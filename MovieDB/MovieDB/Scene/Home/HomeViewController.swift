//
//  HomeViewController.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

import UIKit

class HomeViewController: BaseViewController<HomeViewModel> {
    @IBOutlet weak var movieCollectionListTableView: UITableView!
    
    var collectionModels = [MovieModelProtocol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        configureTableView()
        getCollectionMovies()
    }
    
    private func configureTableView() {
        movieCollectionListTableView.delegate = self
        movieCollectionListTableView.dataSource = self
        
        let tableViewCell = String(describing: MovieCollectionTableViewCell.self)
        movieCollectionListTableView.register(UINib(nibName: tableViewCell, bundle: nil), forCellReuseIdentifier: tableViewCell)
    }
    
    private func getCollectionMovies() {
        viewModel?.getTrendMovies() { [weak self] (data) in
            guard let self else {return}
            if var result = data {
                result.collectionTitle = "Trend Movies"
                self.collectionModels.append(result)
                self.movieCollectionListTableView.reloadData()
            } else {
                print("NOT GET TREND MOVİES")
            }
        }
        
        viewModel?.getPopularMovies(){ [weak self] (data) in
            guard let self else {return}
            if var result = data {
                result.collectionTitle = "Popular Movies"
                self.collectionModels.append(result)
                self.movieCollectionListTableView.reloadData()
            } else {
                print("NOT GET POPULAR MOVİES")
            }
        }
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = String(describing: MovieCollectionTableViewCell.self)
        let cell = movieCollectionListTableView.dequeueReusableCell(withIdentifier: tableViewCell, for: indexPath) as! MovieCollectionTableViewCell
        cell.collectionTitle.text = collectionModels[indexPath.row].collectionTitle
        cell.model = collectionModels[indexPath.row].results
        return cell
    }
    
}

extension HomeViewController: MovieTableViewCellDelegate {
    func selectedId(movieId: Int) {
        print("seçilen id: \(movieId)")
    }
}
