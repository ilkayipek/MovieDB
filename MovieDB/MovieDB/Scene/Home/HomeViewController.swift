//
//  HomeViewController.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

import UIKit

class HomeViewController: BaseViewController<HomeViewModel> {
    @IBOutlet weak var collectionListTableView: UITableView!
    
    var freeToWatchModel = [(order: Int, data: MovieAndTVShowModel?)]()
    var trendingAllModel = [(dayOrWeek: DayOrWeek, data: [MovieAndTVShowsModelResult]?)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        configureTableView()
        getCollectionsMediaData()
    }
    
    private func configureTableView() {
        collectionListTableView.delegate = self
        collectionListTableView.dataSource = self
        
        let trendingAll = String(describing: TrendAllTableViewCell.self)
        collectionListTableView.register(UINib(nibName: trendingAll, bundle: nil), forCellReuseIdentifier: trendingAll)
        
        let movieOrTvShow = String(describing: MovieAndTVShowTableViewCell.self)
        collectionListTableView.register(UINib(nibName: movieOrTvShow, bundle: nil), forCellReuseIdentifier: movieOrTvShow)
    }
    
    private func getCollectionsMediaData() {
        viewModel?.getTrendingAll(dayOrWeek: .day) { [weak self] (data) in
            guard let self else {return}
            self.trendingAllModel.append((.day,data))
        }
        viewModel?.getTrendingAll(dayOrWeek: .week) { [weak self] (data) in
            guard let self else {return}
            self.trendingAllModel.append((.week,data))
        }
        
        viewModel?.getFreeToWatch(.movie) { [weak self] (data) in
            guard let self else {return}
            self.freeToWatchModel.append((1,data))
        }
        
        viewModel?.getFreeToWatch(.tv) { [weak self] (data) in
            guard let self else {return}
            self.freeToWatchModel.append((2,data))
        }
        
        viewModel?.closeDispatchGroup { [weak self] in
            guard let self else {return}
            
            self.freeToWatchModel.sort(by: { $0.order < $1.order })
            self.collectionListTableView.reloadData()
        }
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    //freeToWatchModel + trendingModel
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return freeToWatchModel.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionListTableView.dequeueReusableCell(withIdentifier: String(describing: TrendAllTableViewCell.self)) as! TrendAllTableViewCell
            guard !trendingAllModel.isEmpty else {return UITableViewCell()}
            
            cell.setModels(models: trendingAllModel)
            
            cell.selectedIndexDelegate = self
            cell.cellBackgroundImageLoad()
            
            return cell
        case 1,2:
            let tableViewIndex = indexPath.row
            let (_, data) = freeToWatchModel[tableViewIndex - 1]
            
            if let result = data?.results {
                let cell = collectionListTableView.dequeueReusableCell(withIdentifier: String(describing: MovieAndTVShowTableViewCell.self)) as! MovieAndTVShowTableViewCell
                cell.model = result
                cell.mediaType = data!.mediaType
                cell.selectedIndexDelegate = self
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
    func selectedId(movieId: Int, mediaType: MediaType) {
        let targetVc = DetailMovieViewController.loadFromNib()
        targetVc.movieId = movieId
        self.navigationController?.pushViewController(targetVc, animated: true)
    }
}
