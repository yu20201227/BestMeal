//
//  SearchRouter.swift
//  BestMeal
//
//  Created by Owner on 2021/06/22.
//

import UIKit

protocol SearchWireFrame {
    func getCardsToken(_ view: SearchViewController)
}

class SearchRouter: SearchWireFrame {
    
    internal func getCardsToken(_ view: SearchViewController) {
        view.performSegue(withIdentifier: SegueIdentifier.toCards, sender: nil)
    }

}
