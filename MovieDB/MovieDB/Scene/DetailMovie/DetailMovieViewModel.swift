//
//  DetailMovieViewModel.swift
//  MovieDB
//
//  Created by MacBook on 15.08.2023.
//

import Foundation

class DetailMovieViewModel: BaseViewModel {
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
        let path = Constant.RequestPathMovie.castPath(movieId: movieId)
        Network.shared.getRequestV3(urlPath: path) { (result: Result<MovieActorsModel, Error>) in
            switch result {
            case .success(let data):
                if data.success ?? true {
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                closure(nil)
                print("ERROR MESSAGE: \(error.localizedDescription)")
            }
        }
    }
}
