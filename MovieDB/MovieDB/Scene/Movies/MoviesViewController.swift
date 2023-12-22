//
//  MoviesViewController.swift
//  MovieDB
//
//  Created by MacBook on 7.12.2023.
//

import UIKit

class MoviesViewController: BaseViewController<MoviesViewModel> {
    @IBOutlet weak var collectionListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MoviesViewModel()
        collectionListTableViewConfigure()
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionListTableView.dequeueReusableCell(withIdentifier: String(describing: TrendAllTableViewCell.self), for: indexPath) as! TrendAllTableViewCell
            cell.collectionTitle.text = "Trending"
            return cell
            
        case 1,2,3,4:
            let cell = collectionListTableView.dequeueReusableCell(withIdentifier: String(describing: MovieAndTVShowTableViewCell.self), for: indexPath) as! MovieAndTVShowTableViewCell
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    
}

