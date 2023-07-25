//
//  BaseViewController.swift
//  MovieDB
//
//  Created by MacBook on 19.07.2023.
//

import UIKit

class BaseViewController<V: BaseViewModel>: UIViewController {
    var viewModel: V? {
        didSet {
            setViewModel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func setViewModel() {
        
    }
}
