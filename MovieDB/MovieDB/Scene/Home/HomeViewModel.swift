//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

class HomeViewModel: BaseViewModel {
    func getPopularMovies(resultClosure: @escaping(PopularMoviesModel?) -> Void) {
        let path = Constant.RequestPathMovie.popularMoviesPath()
        Network.shared.getRequestV3(urlPath: path) { (result: Result<PopularMoviesModel, Error>) in
            switch result {
            case .success(let data):
                    if data.success ?? true {
                        resultClosure(data)
                    }
            case .failure(let error):
                print("ERROR MESSAGE: \(error.localizedDescription)")
            }
        }
    }
    
    func getTrendMovies(resultClosure: @escaping(TrendMoviesModel?) -> Void) {
        let path = Constant.RequestPathMovie.trendDayMoviesPath()
        Network.shared.getRequestV3(urlPath: path) { (result: Result<TrendMoviesModel, Error>) in
            switch result {
            case .success(let data):
                if data.success ?? true {
                    resultClosure(data)
                } else {
                    resultClosure(nil)
                }
            case .failure(let error):
                print("ERROR MESSAGE: \(error.localizedDescription)")
            }
        }
    }
}
