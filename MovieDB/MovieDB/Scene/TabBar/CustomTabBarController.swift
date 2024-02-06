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
    let selectedColor: UIColor = .selectedColor
    let unselectedColor: UIColor = .gray
    
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
            items![item].selectedImage = UIImage(systemName: selectedImages[item])?.withRenderingMode(.alwaysOriginal).withTintColor(selectedColor)
            items![item].image = UIImage(systemName: unselectedImages[item])?.withRenderingMode(.alwaysOriginal).withTintColor(unselectedColor)
            items![item].setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: unselectedColor,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13.0)
            ], for: .normal)
            items![item].setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: selectedColor,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13.0)
            ], for: .selected)
        }
        
        
    }
    
    //loads the selected controller
    private func loadController(selectedScene: SceneControllers) -> UIViewController {
        switch selectedScene {
        case .home:
            let homeVc = HomeViewController.loadFromNib()
            homeVc.title = NSLocalizedString("Home", comment: "")
            
            selectedImages.append(IconName.houseFill.rawValue)
            unselectedImages.append(IconName.house.rawValue)
            
            return homeVc
        case .movies:
            let movies = MoviesViewController.loadFromNib()
            movies.title = NSLocalizedString("Movies", comment: "")
            
            selectedImages.append(IconName.movieFill.rawValue)
            unselectedImages.append(IconName.movie.rawValue)
            
            return movies
        }
    }
}

extension CustomTabBarController: UITabBarControllerDelegate {
    
}
