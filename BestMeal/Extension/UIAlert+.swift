//
//  UIAlert+.swift
//  BestMeal
//
//  Created by Owner on 2021/04/24.
//

import UIKit

// MARK: - 他のモジュールへの適応実施。
extension UIAlertController {
    
    func alertAction(title: String?, message: String?, preferredStyle: UIAlertController.Style, selectAction: UIAlertAction) {
    }
    
    func selectAction(title: String?, style: UIAlertAction.Style, handler: @escaping (UIAlertAction) -> Void) {
        print("")
    }
}
