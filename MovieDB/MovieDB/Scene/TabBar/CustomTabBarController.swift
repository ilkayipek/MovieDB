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
        self.tabBar.tintColor = .gray
        
        //necessary controllers created and image icons added.
        let homeVc = loadController(selectedScene: .home)
        
        selectedImages.append(IconName.houseFill.rawValue)
        unselectedImages.append(IconName.house.rawValue)
        
        self.setViewControllers([homeVc], animated: false)
        
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
        switch selectedScene {
        case .home:
            let homeVc = HomeViewController.loadFromNib()
            homeVc.title = NSLocalizedString("Home", comment: "")
            
            let titleAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13.0)
            ]
            
            homeVc.tabBarItem.setTitleTextAttributes(titleAttributes, for: .normal)
            return homeVc
        }
    }
}
