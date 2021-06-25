//
//  CardSwipeRouter.swift
//  BestMeal
//
//  Created by Owner on 2021/06/24.
//

import UIKit

protocol CardSwipeWireFrame {
    func getListToken(_ view: CardSwipeViewController)
    func goBack(_ view: CardSwipeViewController)
}

class CardSwipeRouter: CardSwipeWireFrame {
    
    func getListToken(_ view: CardSwipeViewController) {
        view.performSegue(withIdentifier: SegueIdentifier.toList, sender: nil)
    }
    
    func goBack(_ view: CardSwipeViewController) {
        view.dismiss(animated: true, completion: nil)
    }
}
