//
//  MoviesViewController.swift
//  MovieDB
//
//  Created by MacBook on 7.12.2023.
//

import UIKit

class MoviesViewController: BaseViewController<MoviesViewModel> {
    @IBOutlet weak var collectionListTableView: UITableView!
    
    var movieCollectionsData = [(order: Int,model:MovieAndTVShowModel?)]()
    var trendingModel = [(dayOrWeek: DayOrWeek, data: [MovieAndTVShowsModelResult]?)]()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MoviesViewModel()
        collectionListTableViewConfigure()
        getMovieCollections()
    }
    
    //fetching movies
    func getMovieCollections() {
        viewModel?.fetchTrending(dayOrWeek: .day) { [weak self] data in
            guard let self else {return}
            self.trendingModel.append((dayOrWeek: .day, data: data))
        }
        
        viewModel?.fetchTrending(dayOrWeek: .week) { [weak self] data in
            guard let self else {return}
            self.trendingModel.append((dayOrWeek: .week, data: data))
        }
        
        viewModel?.fetchNowPlaying{ [weak self] data in
            guard let self else {return}
            self.movieCollectionsData.append((order:0, model:data))
        }
        
        viewModel?.fetchUpcoming{ [weak self] data in
            guard let self else {return}
            self.movieCollectionsData.append((order:1, model:data))
        }
        
        viewModel?.fetchPopular{ [weak self] data in
            guard let self else {return}
            self.movieCollectionsData.append((order:2, model:data))
        }
        
        viewModel?.fetchTopRated{ [weak self] data in
            guard let self else {return}
            self.movieCollectionsData.append((order:3, model:data))
        }
        
        //when All Collections fartch complated, movie collections data sorted
        viewModel?.closeDispetchGroup { [weak self] in
            guard let self else {return}
            self.movieCollectionsData.sort(by: {$0.order < $1.order})
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

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource,SelectedIndexDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCollectionsData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionListTableView.dequeueReusableCell(withIdentifier: String(describing: TrendAllTableViewCell.self), for: indexPath) as! TrendAllTableViewCell
            guard !trendingModel.isEmpty else {return TrendAllTableViewCell()}
            
            cell.setModels(models: trendingModel)
            cell.cellBackgroundImageLoad()
            cell.selectedIndexDelegate = self
            return cell
            
        case 1,2,3,4:
            let cell = collectionListTableView.dequeueReusableCell(withIdentifier: String(describing: MovieAndTVShowTableViewCell.self), for: indexPath) as! MovieAndTVShowTableViewCell
            
            let (_,data) = movieCollectionsData[indexPath.row - 1]
            cell.collectionTitle.text = data?.collectionTitle
            
            if let result = data?.results {
                cell.model = result
                cell.selectedIndexDelegate = self
            }
            return cell
            
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func selectedId(movieId: Int, mediaType: MediaType) {
        let targetVc = DetailMovieViewController.loadFromNib()
        targetVc.movieId = movieId
        self.navigationController?.pushViewController(targetVc, animated: true)
    }
}

