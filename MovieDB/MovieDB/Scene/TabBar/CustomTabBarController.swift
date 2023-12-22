//
//  CustomTabBarController.swift
//  MovieDB
//
//  Created by MacBook on 15.10.2023.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    var selectedImages = [String]()
    var unselectedImages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    private func configureTabBar() {
   
        self.tabBar.barTintColor = .DefaultBackgroundColor
        //necessary controllers created and image icons added.
        let homeVc = loadController(selectedScene: .home)
        let moviesVc = loadController(selectedScene: .movies)
        
        self.setViewControllers([homeVc,moviesVc], animated: false)
        
        self.selectedIndex = 0
        let items = self.tabBar.items
        
        //Assigning images to controllers
        for item in 0..<items!.count {
            items![item].selectedImage = UIImage(systemName: selectedImages[item])?.withRenderingMode(.alwaysOriginal)
            items![item].image = UIImage(systemName: unselectedImages[item])?.withRenderingMode(.alwaysOriginal)
        }
        
        
    }
    
    //loads the selected controller
    private func loadController(selectedScene: SceneControllers) -> UIViewController {
        let titleAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13.0)
        ]
        
        switch selectedScene {
        case .home:
            let homeVc = HomeViewController.loadFromNib()
            homeVc.title = NSLocalizedString("Home", comment: "")
            
            selectedImages.append(IconName.houseFill.rawValue)
            unselectedImages.append(IconName.house.rawValue)
            
            homeVc.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
            return homeVc
        case .movies:
            let movies = MoviesViewController.loadFromNib()
            movies.title = NSLocalizedString("Movies", comment: "")
            
            selectedImages.append(IconName.movieFill.rawValue)
            unselectedImages.append(IconName.movie.rawValue)
            
            movies.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
            return movies
        }
    }
}

extension CustomTabBarController: UITabBarControllerDelegate {
    
}
