//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by MacBook on 1.08.2023.
//

class HomeViewModel: BaseViewModel {
    func getTrendingAll(dayOrWeek: DayOrWeek, _ closure: @escaping(MovieAndTVShowModel?) -> Void) {
        let trendAllPath = Constant.RequestPathMovie.trendingAll(dayOrWeek: dayOrWeek)
        
        Network.shared.getRequestV3(urlPath: trendAllPath) { (result: Result<MovieAndTVShowModel?, Error>) in
            switch result {
            case .success(let data):
                if let data = data, !(data.results?.isEmpty ?? true) {
                    closure(data)
                } else {
                    closure(nil)
                }
            case .failure(let error):
                print("MOVİE AND TV MODEL FETCH ERROR: \(error.localizedDescription)")
                closure(nil)
            }
        }
    }
}
