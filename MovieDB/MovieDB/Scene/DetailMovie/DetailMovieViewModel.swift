//
//  DetailMovieViewModel.swift
//  MovieDB
//
//  Created by MacBook on 15.08.2023.
//

import Foundation

class DetailMovieViewModel: BaseViewModel {
    let group = DispatchGroup()
    
    func getMovieDetailTranslation(movieId: Int, closure: @escaping(DetailMovieModel?) -> Void) -> Void {
        let path = Constant.RequestPathMovie.translationMoviePath(movieId: movieId, language: .tr)
        Network.shared.getRequestV3(urlPath: path) { (result: Result<DetailMovieModel?, Error>) in
            switch result {
            case .success(let data):
                if data?.success ?? true {
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                print("ERROR MESSAGE:\(error.localizedDescription)")
                closure(nil)
            }
        }
    }
    
    func getMovieDetailOriginal(movieId: Int, closure: @escaping(DetailMovieModel?) -> Void) -> Void {
        let path = Constant.RequestPathMovie.detailOriginalMoviePath(movieId: movieId)
        Network.shared.getRequestV3(urlPath: path) { (result: Result<DetailMovieModel, Error>) in
            switch result {
            case .success(let data):
                if data.success ?? true {
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                print("ERROR MESSAGE:\(error.localizedDescription)")
                closure(nil)
            }
        }
    }
    
    func getActors(movieId: Int, closure: @escaping(MovieActorsModel?) -> Void) -> Void {
        group.enter()
        let path = Constant.RequestPathMovie.castPath(movieId: movieId)
        
        Network.shared.getRequestV3(urlPath: path) { (result: Result<MovieActorsModel, Error>) in
            switch result {
            case .success(let data):
                if data.success ?? true {
                    closure(data)
                    self.group.leave()
                } else {
                    closure(nil)
                    self.group.leave()
                }
            case .failure(let error):
                closure(nil)
                print("ERROR MESSAGE: \(error.localizedDescription)")
            }
        }
    }
    
    func getTrailers(movieId: Int, closure: @escaping(MovieTrailerModel?) -> Void) {
        group.enter()
        let path = Constant.RequestPathMovie.trailerPath(movieId: movieId)
        
        Network.shared.getRequestV3(urlPath: path) { [weak self] (result: Result<MovieTrailerModel?, Error>) in
            guard let self else {return}
            switch result {
            case .success(let data):
                closure(data)
                self.group.leave()
            case .failure(let error):
                closure(nil)
                self.group.leave()
                print("ERROR MESSAGE: \(error.localizedDescription)")
            }
        }
        
    }
    
    func getSimilarMovie(movieId: Int,_ closure: @escaping(SimilarMovieModel?) -> Void) -> Void {
        group.enter()
        let path = Constant.RequestPathMovie.similarMovies(movieId: movieId)
        
        Network.shared.getRequestV3(urlPath: path) { [weak self] (result: Result<SimilarMovieModel, Error>) in
            guard let self else {return}
            switch result {
            case .success(let data):
                closure(data)
                self.group.leave()
            case .failure(let error):
                closure(nil)
                self.group.leave()
                print("ERROR MESSAGE: \(error.localizedDescription)")
            }
        }
    }
    
    func closeDispatchGroup(_ closure: @escaping() ->Void) -> Void {
        group.notify(queue: .main) {
            closure()
        }
    }
}
