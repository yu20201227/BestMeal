//
//  Presenter.swift
//  BestMeal
//
//  Created by Owner on 2021/04/17.
//

import UIKit

class Presenter: UIViewController, buttonActionOnCardSwipeViewProtocol {
    
    var userButtonAction: buttonActionOnCardSwipeView!
    
    func buttonAction(buttonAction: buttonActionOnCardSwipeView) {
        switch userButtonAction {
        case .toFavListButton:
            userButtonActions()
        case .backButton:
            cancelAction()
        case .none:
            break
        }
    }
    
    private func userButtonActions() {
        performSegue(withIdentifier: SegueIdentifier.gotoList, sender: nil)
    }
    private func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
    
}
