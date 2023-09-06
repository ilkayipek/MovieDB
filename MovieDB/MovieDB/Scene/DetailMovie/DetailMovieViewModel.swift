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
        
        Network.shared.getRequestV3(urlPath: path) { [weak self] (result: Result<MovieActorsModel, Error>) in
            guard let self else {return}
            
            switch result {
            case .success(let data):
                if data.success ?? true, !(data.cast?.isEmpty ?? true) {
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                closure(nil)
                
                print("ERROR MESSAGE: \(error.localizedDescription)")
            }
            self.group.leave()
        }
    }
    
    func getTrailers(movieId: Int, closure: @escaping(MovieTrailerModel?) -> Void) {
        group.enter()
        let path = Constant.RequestPathMovie.trailerPath(movieId: movieId)
        
        Network.shared.getRequestV3(urlPath: path) { [weak self] (result: Result<MovieTrailerModel?, Error>) in
            guard let self else {return}
            
            switch result {
            case .success(let data):
                if data?.results?.isEmpty ?? true {
                    closure(nil)
                } else {
                    closure(data)
                }
            case .failure(let error):
                closure(nil)
                print("ERROR MESSAGE: \(error.localizedDescription)")
            }
            self.group.leave()
        }
        
    }
    
    func getSimilarMovie(movieId: Int,_ closure: @escaping(SimilarMovieModel?) -> Void) -> Void {
        group.enter()
        let path = Constant.RequestPathMovie.similarMovies(movieId: movieId)
        
        Network.shared.getRequestV3(urlPath: path) { [weak self] (result: Result<SimilarMovieModel, Error>) in
            guard let self else {return}
            
            switch result {
            case .success(let data):
                if data.results?.isEmpty ?? true {
                    closure(nil)
                } else {
                   closure(data)
                }
            case .failure(let error):
                closure(nil)
                print("ERROR MESSAGE: \(error.localizedDescription)")
            }
            self.group.leave()
        }
    }
    
    func getReviewsMovie(movieId: Int,_ closure: @escaping(ReviewModel?) -> Void) -> Void {
        group.enter()
        let path = Constant.RequestPathMovie.reviewsMoviePath(movieId: movieId)
        
        Network.shared.getRequestV3(urlPath: path) { [weak self] (result: Result<ReviewModel, Error>) in
            guard let self else {return}
            
            switch result {
            case .success(let data):
                if data.results?.isEmpty ?? true {
                    closure(nil)
                } else {
                   closure(data)
                }
            case .failure(let error):
                closure(nil)
                print("ERROR MESSAGE: \(error.localizedDescription)")
            }
            self.group.leave()
        }
    }
    
    func closeDispatchGroup(_ closure: @escaping() ->Void) -> Void {
        group.notify(queue: .main) {
            closure()
        }
    }
}
