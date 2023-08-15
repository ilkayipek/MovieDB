//
//  DetailMovieViewController.swift
//  MovieDB
//
//  Created by MacBook on 15.08.2023.
//

import UIKit

class DetailMovieViewController: BaseViewController<DetailMovieViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailMovieViewModel()
    }
}
