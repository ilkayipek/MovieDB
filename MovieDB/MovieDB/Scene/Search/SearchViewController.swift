//
//  SearchViewController.swift
//  MovieDB
//
//  Created by MacBook on 6.02.2024.
//

import UIKit

class SearchViewController: BaseViewController<SearchViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchViewModel()
    }

}
