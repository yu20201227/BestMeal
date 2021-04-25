//
//  UIStoryboard+.swift
//  BestMeal
//
//  Created by Owner on 2021/04/25.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    class func storyboardTransition(storyboardName: String, viewControllerName: String? = nil) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        if let viewControllerName = viewControllerName {
            return storyboard.instantiateViewController(withIdentifier: viewControllerName)
        }
        return storyboard.instantiateInitialViewController()
    }
}
