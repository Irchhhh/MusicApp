//
//  UIViewController + Storyboard.swift
//  MusicApp
//
//  Created by Ирина on 03.03.2022.
//

import Foundation
import UIKit

extension UIViewController {
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("error: \(name)")
        }
        
    }
}
