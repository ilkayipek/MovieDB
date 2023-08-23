//
//  TrailerWebViewViewController.swift
//  MovieDB
//
//  Created by MacBook on 23.08.2023.
//

import UIKit
import WebKit

class TrailerWebViewViewController: BaseViewController<TrailerWebViewViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TrailerWebViewViewModel()
        
    }
}
