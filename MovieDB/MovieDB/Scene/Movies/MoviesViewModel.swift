//
//  MoviesViewModel.swift
//  MovieDB
//
//  Created by MacBook on 7.12.2023.
//
import Foundation

class MoviesViewModel: BaseViewModel {
    let dispetchGroup = DispatchGroup()
    
    func startDispatchGroup() {
        dispetchGroup.enter()
        gradientLoagingTabAnimation?.startAnimations()
    }
    
    func fetchTrending(dayOrWeek: DayOrWeek, _ closure: @escaping([MovieAndTVShowsModelResult]?) -> Void) -> Void {
        let  path = Constant.RequestPathMovie.trendingMoviesPath(dayOrWeek: dayOrWeek)
        startDispatchGroup()
        
        Network.shared.getRequestV3(urlPath: path) {[weak self] (result:Result<MovieAndTVShowModel, Error>) in
            guard let self else {return}
            
            switch result {
            case .success(var data):
                data.collectionTitle = "Trending"
                if let result = data.results, !result.isEmpty {
                    closure(result)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                closure(nil)
                print("Trending fatch error:\(error.localizedDescription)")
            }
            
            self.dispetchGroup.leave()
        }
    }
    
    func fetchNowPlaying(_ closure: @escaping(MovieAndTVShowModel?)-> Void) -> Void {
        dispetchGroup.enter()
        let path = Constant.RequestPathMovie.movieCollectionPath(collection: .nowPlaying, page: nil)
        
        Network.shared.getRequestV3(urlPath: path) {[weak self] (result:Result<MovieAndTVShowModel, Error>) in
            guard let self else {return}
            
            switch result {
            case .success(var data):
                data.collectionTitle = "Now Playing"
                data.collection = .nowPlaying
                
                if let result = data.results, !result.isEmpty {
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                closure(nil)
                print("Now playing fatch error:\(error.localizedDescription)")
            }
            
            self.dispetchGroup.leave()
        }
    }
    
    func fetchUpcoming(_ closure: @escaping(MovieAndTVShowModel?)-> Void) -> Void {
        dispetchGroup.enter()
        let path = Constant.RequestPathMovie.movieCollectionPath(collection: .upcoming, page: nil)
        
        Network.shared.getRequestV3(urlPath: path) { [weak self] (result:Result<MovieAndTVShowModel, Error>) in
            guard let self else {return}
            
            switch result {
            case .success(var data):
                data.collectionTitle = "Upcoming"
                data.collection = .upcoming
                
                if let result = data.results, !result.isEmpty {
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                closure(nil)
                print("Upcoming fatch error:\(error.localizedDescription)")
            }
            
            self.dispetchGroup.leave()
        }
    }
    
    func fetchPopular(_ closure: @escaping(MovieAndTVShowModel?)-> Void) -> Void {
        dispetchGroup.enter()
        let path = Constant.RequestPathMovie.movieCollectionPath(collection: .popular, page: nil)
        
        Network.shared.getRequestV3(urlPath: path) { [weak self] (result:Result<MovieAndTVShowModel, Error>) in
            guard let self else {return}
            
            switch result {
            case .success(var data):
                data.collectionTitle = "Popular"
                data.collection = .popular
                
                if let result = data.results, !result.isEmpty {
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                closure(nil)
                print("Popular fatch error:\(error.localizedDescription)")
            }
            
            self.dispetchGroup.leave()
        }
    }
    
    func fetchTopRated(_ closure: @escaping(MovieAndTVShowModel?)-> Void) -> Void {
        dispetchGroup.enter()
        let path = Constant.RequestPathMovie.movieCollectionPath(collection: .topRated, page: nil)
        
        Network.shared.getRequestV3(urlPath: path) {[weak self] (result:Result<MovieAndTVShowModel, Error>) in
            guard let self else {return}
            
            switch result {
            case .success(var data):
                data.collectionTitle = "Top Rated"
                data.collection = .topRated
                
                if let result = data.results, !result.isEmpty {
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                closure(nil)
                print("Top rated fatch error:\(error.localizedDescription)")
            }
            
            self.dispetchGroup.leave()
        }
    }
    
    //grouping closed
    func closeDispetchGroup(_ closure: @escaping()->Void) -> Void {
        dispetchGroup.notify(queue: .main) { [weak self] in
            guard let self else {return}
            closure()
            self.gradientLoagingTabAnimation?.stopAnimations()
        }
    }
}
