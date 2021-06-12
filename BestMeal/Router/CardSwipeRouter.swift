//
//  CardSwipeRouter.swift
//  BestMeal
//
//  Created by Owner on 2021/06/12.
//

import UIKit

protocol CardSwipeWireFrame {
    func didTapGoToList()
    
}

class CardSwipeRouter: UIViewController, CardSwipeWireFrame {
    
    var presenterProtocol: CardSwipePresenterProtocol?
    var cardSwipeWireFrame: CardSwipeWireFrame?
        
@discardableResult
 private func assembleModule(_ delegate: CardSwipePresenterProtocol) -> UIViewController {
        // UIViewControllerの生成とか色々
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "CardSwipeViewController") as! CardSwipeViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
        performSegue(withIdentifier: SegueIdentifier.toList, sender: nil)
        //let presenter = CardSwipeViewPresenter(delegate)
        return secondViewController
    }


    func didTapGoToList() {
        self.cardSwipeWireFrame?.didTapGoToList()
        self.assembleModule(presenterProtocol!)
    }
}
