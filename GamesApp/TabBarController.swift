//
//  TabBarController.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 19.03.2025.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gamesVC = GamesVC()
        gamesVC.title = "Games"
        let gamesNavController = createNavigationController(for: gamesVC, title: "Games")
        
        
        let favouritesVC = FavouritesVC()
        favouritesVC.title = "Favourites"
        let favouritesNavController = createNavigationController(for: favouritesVC, title: "Favourites")
        
        gamesNavController.tabBarItem = UITabBarItem(title: "Games",
                                                     image: UIImage(named: "Games"),
                                                     selectedImage: UIImage(named: "Games"))
        
        favouritesNavController.tabBarItem = UITabBarItem(title: "Favourites",
                                                     image: UIImage(named: "Favourite"),
                                                     selectedImage: UIImage(named: "Favourite"))
        
        viewControllers = [gamesNavController, favouritesNavController]
    }
    
    private func createNavigationController(for rootViewController: UIViewController, title: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        rootViewController.title = title
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
}
