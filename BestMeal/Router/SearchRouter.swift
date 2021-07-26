//
//  SearchRouter.swift
//  BestMeal
//
//  Created by Owner on 2021/06/22.
//

import UIKit

protocol SearchWireFrame {
    func getCardsToken(_ view: SearchViewController)
    func didTapAccessPlaceList(_ view: SearchViewController)
}

class SearchRouter: SearchWireFrame {
    
    func getCardsToken(_ view: SearchViewController) {
        view.performSegue(withIdentifier: SegueIdentifier.toCards, sender: nil)
    }
    
    func didTapAccessPlaceList(_ view: SearchViewController) {
        let secondViewController = view.storyboard?.instantiateViewController(withIdentifier: "FavoritePlaceListViewController") as! FavoritePlaceListViewController
        view.navigationController?.pushViewController(secondViewController, animated: true)
    }
}
