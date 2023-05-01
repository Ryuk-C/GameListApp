//
//  TabBarController.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import UIKit

final class TabBarController: UITabBarController {

    private let homeViewController = UINavigationController(rootViewController: HomeScreen())
    private let favoritesViewController = UINavigationController(rootViewController: FavoriteScreen())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
// MARK: - UI Configure
    private func configure() {
        homeViewController.tabBarItem.image = UIImage(systemName: "gamecontroller.fill")
        favoritesViewController.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        homeViewController.title = "Home"
        favoritesViewController.title = "Favorites"
        
        tabBar.tintColor = .red
        tabBar.backgroundColor = .systemBackground
        setViewControllers([homeViewController, favoritesViewController], animated: true)
    }
}
