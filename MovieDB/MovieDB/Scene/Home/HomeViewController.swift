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
        configureTableView()
    }
    
    private func configureTableView() {
        movieCollectionListTableView.delegate = self
        movieCollectionListTableView.dataSource = self
        
        let tableViewCell = String(describing: MovieCollectionTableViewCell.self)
        movieCollectionListTableView.register(UINib(nibName: tableViewCell, bundle: nil), forCellReuseIdentifier: tableViewCell)
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = String(describing: MovieCollectionTableViewCell.self)
        let cell = movieCollectionListTableView.dequeueReusableCell(withIdentifier: tableViewCell, for: indexPath) as! MovieCollectionTableViewCell
        cell.collectionTitle.text = "trial tableView cell"
        return cell
    }
}
