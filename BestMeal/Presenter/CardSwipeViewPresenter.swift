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
    
    var interactor: CardSwipeUseCase = CardSwipeInteractor()
    var router: CardSwipeWireFrame = CardSwipeRouter()
    
    func gotoListScreen(_ view: CardSwipeViewController) {
        self.router.getListToken(view)
    }
    
    func goBackToPreviousScreen(_ view: CardSwipeViewController) {
        self.router.goBack(view)
    }

}
