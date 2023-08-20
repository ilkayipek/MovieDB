//
//  DetailMovieTableViewCell.swift
//  MovieDB
//
//  Created by MacBook on 17.08.2023.
//

import UIKit

class DetailMovieTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionViewTiltleLabel: UILabel!
    @IBOutlet weak var  collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
        collectionView.reloadData()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let actors = String(describing: ActorsCollectionViewCell.self)
        collectionView.register(UINib(nibName: actors, bundle: nil), forCellWithReuseIdentifier: actors)
        
        let trailer = String(describing: TrailerCollectionViewCell.self)
        collectionView.register(UINib(nibName: trailer, bundle: nil), forCellWithReuseIdentifier: trailer)
    }
    
}

extension DetailMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TrailerCollectionViewCell.self), for: indexPath) as! TrailerCollectionViewCell
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 225, height: 125)
    }
}

