//
//  MoviesViewController.swift
//  MovieDB
//
//  Created by MacBook on 7.12.2023.
//

import UIKit

class MoviesViewController: BaseViewController<MoviesViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MoviesViewModel()
        
    }
}
