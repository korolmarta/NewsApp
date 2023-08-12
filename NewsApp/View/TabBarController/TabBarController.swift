//
//  TabBarController.swift
//  NewsApp
//
//  Created by Marta Korol on 09.08.2023.
//

import UIKit

final class TabBarController: UITabBarController {

    var discoverTabItem: UITabBarItem {
        let image = UIImage(systemName: "doc.text.magnifyingglass")
        return UITabBarItem(title: "Discover", image: image, tag: 0)
    }

    var favouriteTabItem: UITabBarItem {
        let image = UIImage(systemName: "bookmark.square")
        return UITabBarItem(title: "Favorite", image: image, tag: 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        createTabs()
    }

    private func setupTabBar() {
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        tabBar.backgroundColor = .systemBackground
        tabBar.unselectedItemTintColor = .lightGray
    }

    private func createTabs() {
        let discoverVC = DiscoverViewController(nibName: DiscoverViewController.identifier, bundle: nil)
        discoverVC.tabBarItem = discoverTabItem
        let favouriteVC = SavedNewsViewController()
        favouriteVC.tabBarItem = favouriteTabItem

        let controllerArray = [discoverVC, favouriteVC]
        viewControllers = controllerArray.map{ UINavigationController(rootViewController: $0) }
    }
}
