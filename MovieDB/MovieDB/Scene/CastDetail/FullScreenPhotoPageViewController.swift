//
//  FullScreenPhotoPageViewController.swift
//  MovieDB
//
//  Created by MacBook on 11.10.2023.
//

import UIKit

class FullScreenPhotoPageViewController: UIViewController {
    
    var fullScreenImagePageViewController: UIPageViewController!
    var images: [UIImage]?
    var selectedImageIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}

extension FullScreenPhotoPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return UIViewController()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return UIViewController()
    }
    
    
}
