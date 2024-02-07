//
//  SearchViewController.swift
//  MovieDB
//
//  Created by MacBook on 6.02.2024.
//

import UIKit

class SearchViewController: BaseViewController<SearchViewModel> {

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       searchBarConfiguration()
    }
    
    private func searchBarConfiguration() {
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 15)
        
        if let originalImage = UIImage(systemName: IconName.search.rawValue) {
            let newSize = CGSize(width: originalImage.size.width * 1.5, height: originalImage.size.height * 1.5)
            
            let resizedImage = originalImage.resize(targetSize: newSize).withTintColor(UIColor.LabelColor, renderingMode: .alwaysOriginal)
            searchBar.setImage(resizedImage, for: .search, state: .normal)
        }
        
        if let originalImage = UIImage().setSystemIcone(.closeFill) {
            let newSize = CGSize(width: originalImage.size.width * 1.5, height: originalImage.size.height * 1.5)
            
            let resizedImage = originalImage.resize(targetSize: newSize).withTintColor(UIColor.LabelColor, renderingMode: .alwaysOriginal)
            
            searchBar.setImage(resizedImage, for: .clear, state: .normal)
        }
    }
    
    

}
