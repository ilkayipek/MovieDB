//
//  HomeViewController.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

import UIKit

class HomeViewController: BaseViewController<HomeViewModel> {
    @IBOutlet weak var collectionListTableView: UITableView!
    
    var collectionModels = [(order: Int, data: MovieAndTVShowModel?)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        configureTableView()
        getCollectionsMediaData()
    }
    
    private func configureTableView() {
        collectionListTableView.delegate = self
        collectionListTableView.dataSource = self
        
        let trendingAll = String(describing: HomeTrendAllTableViewCell.self)
        collectionListTableView.register(UINib(nibName: trendingAll, bundle: nil), forCellReuseIdentifier: trendingAll)
        
        let movieOrTvShow = String(describing: MovieAndTVShowTableViewCell.self)
        collectionListTableView.register(UINib(nibName: movieOrTvShow, bundle: nil), forCellReuseIdentifier: movieOrTvShow)
    }
    
    private func getCollectionsMediaData() {
        viewModel?.getTrendingAll(dayOrWeek: .day) { [weak self] (data) in
            guard let self else {return}
            
            var result = data
            result?.collectionTitle = NSLocalizedString("Trending", comment: "")
            self.collectionModels.append((0,result))
            collectionListTableView.reloadData()
        }
        viewModel?.getTrendingAll(dayOrWeek: .week) { [weak self] (data) in
            guard let self else {return}
            
            var result = data
            result?.collectionTitle = NSLocalizedString("Trending", comment: "")
            self.collectionModels.append((1,result))
            collectionListTableView.reloadData()
        }
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionModels.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            
            
            let cell = collectionListTableView.dequeueReusableCell(withIdentifier: String(describing: HomeTrendAllTableViewCell.self)) as! HomeTrendAllTableViewCell
            
            let resultTuday = collectionModels[0].data?.results
            let resultWeek = collectionModels[1].data?.results
            
            cell.currentModel = resultTuday
            cell.models.append(resultTuday)
            cell.models.append(resultWeek)
            cell.collectionTitle.text = collectionModels[0].data?.collectionTitle
            cell.selectedIndexDelegate = self
            cell.cellBackgroundImageLoad()
            
            return cell
            
        case 2:
            let (_, data) = collectionModels[indexPath.row]
            
            if let result = data?.results {
                let cell = collectionListTableView.dequeueReusableCell(withIdentifier: String(describing: MovieAndTVShowTableViewCell.self)) as! MovieAndTVShowTableViewCell
                cell.model = result
                cell.collectionTitle.text = data?.collectionTitle
                return cell
            } else {
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
}

extension HomeViewController: SelectedIndexDelegate {
    func selectedId(movieId: Int) {
        let targetVc = DetailMovieViewController.loadFromNib()
        targetVc.movieId = movieId
        self.navigationController?.pushViewController(targetVc, animated: true)
    }
}
