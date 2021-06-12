//
//  SearchRouter.swift
//  BestMeal
//
//  Created by Owner on 2021/06/12.
//

import UIKit

protocol SearchWireFrame {
    func didTapMoveToFavoriteList()
}

class SearchRouter: UIViewController, SearchWireFrame {
    
    func didTapMoveToFavoriteList() {
    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "FavoritePlaceListViewController") as! FavoritePlaceListViewController
    self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
}
