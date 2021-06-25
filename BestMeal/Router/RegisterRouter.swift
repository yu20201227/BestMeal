//
//  RegisterRouter.swift
//  BestMeal
//
//  Created by Owner on 2021/06/21.
//

import UIKit

protocol RegisterWireFrame {
    func getSearchToken(_ view: RegisterViewController)
}

class RegisterRouter: RegisterWireFrame {
    
    internal func getSearchToken(_ view: RegisterViewController) {
        view.performSegue(withIdentifier: SegueIdentifier.toSearch, sender: nil)
    }
}
