//
//  CardSwipeViewPresenter.swift
//  BestMeal
//
//  Created by Owner on 2021/06/05.
//

import Foundation

protocol CardSwipePresenter {
    func gotoListScreen(_ view: CardSwipeViewController)
    func goBackToPreviousScreen(_ view: CardSwipeViewController)
}

class CardSwipeViewPresenter: CardSwipePresenter {
    
    var interactor: CardSwipeUseCase = CardSwipeViewController()
    var router: CardSwipeWireFrame = CardSwipeViewController()
    
    func gotoListScreen(_ view: CardSwipeViewController) {
        self.router.getListToken(view)
    }
    
    func goBackToPreviousScreen(_ view: CardSwipeViewController) {
        self.router.goBack(view)
    }

}
