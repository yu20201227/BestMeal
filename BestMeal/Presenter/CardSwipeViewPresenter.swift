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

final class CardSwipeViewPresenter: CardSwipePresenter {
    
    private var interactor: CardSwipeUseCase = CardSwipeInteractor()
    private var router: CardSwipeWireFrame = CardSwipeRouter()
    
    func gotoListScreen(_ view: CardSwipeViewController) {
        self.router.getListToken(view)
    }
    
    func goBackToPreviousScreen(_ view: CardSwipeViewController) {
        self.router.goBack(view)
    }

}
