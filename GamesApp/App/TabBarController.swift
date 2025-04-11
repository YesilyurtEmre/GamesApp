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
    setupTabBar()
  }
  private func setupTabBar() {
    let gamesNav = createTab(
      for: GamesVC(),
      title: "Games",
      imageName: "Games"
    )
    let favouritesNav = createTab(
      for: FavouritesVC(),
      title: "Favourites",
      imageName: "Favourite"
    )
    viewControllers = [gamesNav, favouritesNav]
  }
  private func createTab(for viewController: UIViewController,
                         title: String, imageName: String) -> UINavigationController {
    let navController = UINavigationController(rootViewController: viewController)
    viewController.title = title
    navController.navigationBar.prefersLargeTitles = true
    navController.tabBarItem = UITabBarItem(
      title: title,
      image: UIImage(named: imageName),
      selectedImage: UIImage(named: imageName)
    )
    return navController
  }
}
