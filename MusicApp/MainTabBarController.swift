//
//  MainTabBarController.swift
//  MusicApp
//
//  Created by Ирина on 28.02.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    let searchViewController: SearchViewController = SearchViewController.loadFromStoryboard()
    override func viewDidLoad() {
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)
        
        viewControllers = [
            generateNavigationVC(rootViewController: searchViewController, title: "Search", image: #imageLiteral(resourceName: "Search")),
            generateNavigationVC(rootViewController: ViewController(), title: "Library", image: #imageLiteral(resourceName: "Library - Selected"))
        ]
    }
    
    private func generateNavigationVC(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        navigationViewController.tabBarItem.image = image
        navigationViewController.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationViewController.navigationBar.prefersLargeTitles = true
        
        return navigationViewController
    }
}
