//
//  MainTabBarController.swift
//  MusicApp
//
//  Created by Ирина on 28.02.2022.
//

import UIKit
import SwiftUI

protocol MainTabBarControllerProtocol: AnyObject {
    func minimizeTrackDetailController()
    func maximizeTrackDetailController(viewModel: SearchViewModel.Cell?)
}

class MainTabBarController: UITabBarController {
    let searchViewController: SearchViewController = SearchViewController.loadFromStoryboard()
    let trackDetailView: TrackDetailView = TrackDetailView.loadFromNib()

    private var minimizeTopAnchorConstraint: NSLayoutConstraint!
    private var maximizeTopAnchorConstraint: NSLayoutConstraint!
    private var bottomAnchorConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)
        var library = Library()
        library.tabBarDelegate = self
        let hostingViewController = UIHostingController(rootView: library)
        
        hostingViewController.tabBarItem.image = #imageLiteral(resourceName: "library")
        hostingViewController.tabBarItem.title = "Library"

        viewControllers = [
            hostingViewController,
            generateNavigationVC(rootViewController: searchViewController, title: "Search", image: #imageLiteral(resourceName: "Search"))
        ]
        setupTrackDetailView()
        searchViewController.mainTabBarDelegate = self
    }
    
    private func generateNavigationVC(
        rootViewController: UIViewController, title: String, image: UIImage
    ) -> UIViewController {
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        navigationViewController.tabBarItem.image = image
        navigationViewController.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationViewController.navigationBar.prefersLargeTitles = true
        
        return navigationViewController
    }
    
    private func setupTrackDetailView() {
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        trackDetailView.tabBarDelegate = self
        trackDetailView.delegate = searchViewController
        view.insertSubview(trackDetailView, belowSubview: tabBar)

        maximizeTopAnchorConstraint = trackDetailView.topAnchor.constraint(
            equalTo: view.topAnchor, constant: view.frame.height
        )
        minimizeTopAnchorConstraint = trackDetailView.topAnchor.constraint(
            equalTo: tabBar.topAnchor, constant: -64
        )
        bottomAnchorConstraint = trackDetailView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor, constant: view.frame.height
        )
        bottomAnchorConstraint.isActive = true
        maximizeTopAnchorConstraint.isActive = true
        
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        // trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension MainTabBarController: MainTabBarControllerProtocol {
    func maximizeTrackDetailController(viewModel: SearchViewModel.Cell?) {
        minimizeTopAnchorConstraint.isActive = false
        maximizeTopAnchorConstraint.isActive = true
        
        maximizeTopAnchorConstraint.constant = 0
        bottomAnchorConstraint.constant = 0
        
        UIView.animate(
            withDuration: 0.5, delay: 0,
            usingSpringWithDamping: 0.7, initialSpringVelocity: 1,
            options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
                self.tabBar.alpha = 0
                self.trackDetailView.miniTrackView.alpha = 0
                self.trackDetailView.maximizedStackView.alpha = 1
            },
            completion: nil
        )
        
        guard let viewModel = viewModel else { return }
        self.trackDetailView.set(viewModel: viewModel)
    }
    
    func minimizeTrackDetailController() {
        maximizeTopAnchorConstraint.isActive = false
        bottomAnchorConstraint.constant = view.frame.height
        minimizeTopAnchorConstraint.isActive = true
        
        UIView.animate(
            withDuration: 0.5, delay: 0,
            usingSpringWithDamping: 0.7, initialSpringVelocity: 1,
            options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
                self.tabBar.alpha = 1
                self.trackDetailView.miniTrackView.alpha = 1
                self.trackDetailView.maximizedStackView.alpha = 0
            },
            completion: nil
        )
    }
}
