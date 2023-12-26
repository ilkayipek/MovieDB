//
//  MoviesViewModel.swift
//  MovieDB
//
//  Created by MacBook on 7.12.2023.
//

class MoviesViewModel: BaseViewModel {
    
    func fetchNowPlaying(_ closure: @escaping(MovieAndTVShowModel?)-> Void) -> Void {
        let path = Constant.RequestPathMovie.nowPlayingMoviePath()
        
        Network.shared.getRequestV3(urlPath: path) { (result:Result<MovieAndTVShowModel, Error>) in
            switch result {
            case .success(var data):
                data.collectionTitle = "Now Playing"
                if let result = data.results, !result.isEmpty {
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                closure(nil)
                print("Now playing fatch error:\(error.localizedDescription)")
            }
        }
    }
    
    func fetchPopular(_ closure: @escaping(MovieAndTVShowModel?)-> Void) -> Void {
        let path = Constant.RequestPathMovie.popularMoviesPath()
        
        Network.shared.getRequestV3(urlPath: path) { (result:Result<MovieAndTVShowModel, Error>) in
            switch result {
            case .success(var data):
                data.collectionTitle = "Popular"
                if let result = data.results, !result.isEmpty {
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                closure(nil)
                print("Popular fatch error:\(error.localizedDescription)")
            }
        }
    }
    
    func fetchTopRated(_ closure: @escaping(MovieAndTVShowModel?)-> Void) -> Void {
        let path = Constant.RequestPathMovie.topRatedMoviePath()
        
        Network.shared.getRequestV3(urlPath: path) { (result:Result<MovieAndTVShowModel, Error>) in
            switch result {
            case .success(var data):
                data.collectionTitle = "Top Rated"
                if let result = data.results, !result.isEmpty {
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                closure(nil)
                print("Top rated fatch error:\(error.localizedDescription)")
            }
        }
    }
    
    func fetchUpcoming(_ closure: @escaping(MovieAndTVShowModel?)-> Void) -> Void {
        let path = Constant.RequestPathMovie.upcomingMoviePath()
        
        Network.shared.getRequestV3(urlPath: path) { (result:Result<MovieAndTVShowModel, Error>) in
            switch result {
            case .success(var data):
                data.collectionTitle = "Upcoming"
                if let result = data.results, !result.isEmpty {
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                closure(nil)
                print("Upcoming fatch error:\(error.localizedDescription)")
            }
        }
    }
}
