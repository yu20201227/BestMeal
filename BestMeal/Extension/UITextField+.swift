//
//  UITextField+.swift
//  BestMeal
//
//  Created by Owner on 2021/04/18.
//
import UIKit

extension UITextField {
    
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
