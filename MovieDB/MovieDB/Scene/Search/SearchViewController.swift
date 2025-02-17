//
//  SearchViewController.swift
//  MovieDB
//
//  Created by MacBook on 6.02.2024.
//

import UIKit

class SearchViewController: BaseViewController<SearchViewModel> {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsTableView: UITableView!
    private var resultCollectionModels = [(order: Int,data: SearchResultProtocol?)]()
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchViewModel()
        tableViewConfiguration()
        setKeyboardAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       searchBarConfiguration()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true) // Klavyeyi kapat
    }
    
    private func getSearchResults(queryString: String) {
        viewModel?.fetchMovieResults(queryString: queryString) { [weak self] data in
            guard let self else {return}
            self.resultCollectionModels.append((order: 1, data: data))
        }
        
        viewModel?.fetchTvShowResults(queryString: queryString) { [weak self] data in
            guard let self else {return}
            self.resultCollectionModels.append((order: 2, data: data))
        }
        
        viewModel?.fetchPeopleResults(queryString: queryString) { [weak self] data in
            guard let self else {return}
            self.resultCollectionModels.append((order: 3, data: data))
        }
        
        viewModel?.closeDispetchGroup { [weak self] in
            guard let self else {return}
            self.resultCollectionModels.sort(by: {$0.order < $1.order})
            self.resultsTableView.reloadData()
        }
    }
    
    private func searchBarConfiguration() {
        searchBar.delegate = self
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
    
    private func setKeyboardAppearance() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    private func  tableViewConfiguration() {
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        
        let movieAndTvShowCellString = String(describing: MovieAndTvShowSearchTableViewCell.self)
        resultsTableView.register(UINib(nibName: movieAndTvShowCellString, bundle: nil), forCellReuseIdentifier: movieAndTvShowCellString)
        
        let peopleCellString = String(describing: PeopleSearchTableViewCell.self)
        resultsTableView.register(UINib(nibName: peopleCellString, bundle: nil), forCellReuseIdentifier: peopleCellString)
    }

}

extension SearchViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultCollectionModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0,1:
            let cell = resultsTableView.dequeueReusableCell(withIdentifier: String(describing: MovieAndTvShowSearchTableViewCell.self), for: indexPath) as! MovieAndTvShowSearchTableViewCell
            
            let (_,data) = resultCollectionModels[indexPath.row]
            if ((data as? MovieAndTVShowModel) != nil) {
                cell.setmodel(data: (data as! MovieAndTVShowModel))
                cell.selectedIndexDelegate = self
            }
            cell.collectionView.reloadData()
            
            return cell
        case 2:
            let cell = resultsTableView.dequeueReusableCell(withIdentifier: String(describing: PeopleSearchTableViewCell.self), for: indexPath) as! PeopleSearchTableViewCell
            
            let (_,data) = resultCollectionModels[indexPath.row]
            if ((data as? PeopleModel) != nil) {
                cell.setmodel(data: (data as! PeopleModel))
                cell.selectedIndexDelegate = self
            }
            cell.collectionView.reloadData()
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        resultCollectionModels.removeAll()
        resultsTableView.reloadData()

        timer?.invalidate()
        if searchText != "" {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                self.getSearchResults(queryString: searchText)
                timer.invalidate()
            }
        }
        
    }
}

extension SearchViewController: SelectedCellIndexDelegate {
    func selectedIdMovie(id: Int) {
        let targetVc = DetailMovieViewController.loadFromNib()
        targetVc.movieId = id
        self.navigationController?.pushViewController(targetVc, animated: true)
    }
    
    func selectedIdTvShow(id: Int) {

    }
    
    func selectedIdPerson(id: Int) {
        let targetVc = CastDetailViewController.loadFromNib()
        targetVc.castId = id
        self.navigationController?.pushViewController(targetVc, animated: true)
    }
}

extension SearchViewController: SelectedCollectionDelegate {
    func tappedMoreButtonMovie() {
        let targetVc = AllListCollectionViewController.loadFromNib()
    }
    
    func tappedMoreButtonTvShow() {
        
    }
    
    func tappedMoreButtonPeople() {
        
    }
}
