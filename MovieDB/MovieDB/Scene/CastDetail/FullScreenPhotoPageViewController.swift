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
    var controllers = [FullScreenImageViewController?]()
    var pageNumberInfoLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePageViewController()
        
        configureRightTopBar()
        
    }
    
    private func configureRightTopBar() {
        pageNumberInfoLabel.text = "\(selectedImageIndex + 1)/\(controllers.count)"
        pageNumberInfoLabel.textColor = UIColor.white
        pageNumberInfoLabel.font = UIFont.systemFont(ofSize: 17.0)
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.imageView?.tintColor = .white
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [pageNumberInfoLabel, button])
        stackView.axis = .horizontal
        stackView.spacing = 30

        
        let stackItem = UIBarButtonItem(customView: stackView)
        self.navigationItem.rightBarButtonItem = stackItem
    }
    
    @objc func buttonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configurePageViewController() {
        fullScreenImagePageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        fullScreenImagePageViewController.dataSource = self
        
        if let images {
            for image in images {
                let vc = FullScreenImageViewController(nibName: String(describing: FullScreenImageViewController.self), bundle: nil)
                vc.setImage(image: image)
                controllers.append(vc)
            }
            
            if let controller = controllers[selectedImageIndex] {
                fullScreenImagePageViewController.setViewControllers([controller], direction: .forward, animated: true, completion: nil)
            }
        }
        
        addChild(fullScreenImagePageViewController)
        view.addSubview(fullScreenImagePageViewController.view)
    }

}

extension FullScreenPhotoPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let indexOfCurrentPageViewController = controllers.firstIndex(of: (viewController as? FullScreenImageViewController))!
            if indexOfCurrentPageViewController == 0 {
             return nil // To show there is no previous page
            } else {
              // Previous UIViewController instance
                pageNumberInfoLabel.text = "\(indexOfCurrentPageViewController)/\(controllers.count)"
              return controllers[indexOfCurrentPageViewController - 1]
            }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let indexOfCurrentPageViewController = controllers.firstIndex(of: (viewController as? FullScreenImageViewController))!
        if indexOfCurrentPageViewController == controllers.count - 1 {
             return nil // To show there is no previous page
            } else {
              // Previous UIViewController instance
                pageNumberInfoLabel.text = "\(indexOfCurrentPageViewController + 1)/\(controllers.count)"
              return controllers[indexOfCurrentPageViewController + 1]
            }
        
    }
    
    
}
