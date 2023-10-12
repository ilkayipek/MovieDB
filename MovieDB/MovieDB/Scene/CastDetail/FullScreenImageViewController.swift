//
//  FullScreenImageViewController.swift
//  MovieDB
//
//  Created by MacBook on 11.10.2023.
//

import UIKit

class FullScreenImageViewController: UIViewController {
    
    @IBOutlet weak var castImageView: UIImageView!
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image {
            setImage(image: image)
        }
       
    }
    
    func setImage(image: UIImage?) {
        if isViewLoaded {
            self.castImageView.image = image
        } else {
            // Görünüm henüz yüklenmediyse, görüntüyü imagee adlı özel bir değişkene atayın.
            self.image = image
        }
    }

}
