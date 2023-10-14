//
//  ReviewListViewController.swift
//  MovieDB
//
//  Created by MacBook on 14.10.2023.
//

import UIKit

class ReviewListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var reviewList: ReviewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
    }
    
    private func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        
        let cellSting = String(describing: ReviewTableViewCell.self)
        tableView.register(UINib(nibName: cellSting, bundle: nil), forCellReuseIdentifier: cellSting)
    }

}

extension ReviewListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReviewTableViewCell.self), for: indexPath) as! ReviewTableViewCell
        
        if let review = reviewList?.results?[indexPath.row] {
            cell.setReview(review: review)
        }
        
        return cell
    }
    
    
}
