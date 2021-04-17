//
//  Router.swift
//  BestMeal
//
//  Created by Owner on 2021/04/17.
//

import UIKit

//struct RouterStruct {
//
//    func moveToNext() {
//
//    }
//}



class Router: UIViewController {
    
    enum RouterStruct {
        case moveToNext
        case cancel
    }
    
    
//    func moveToNextByFunc -> (RouterStruct) {
//        performSegue(withIdentifier: SegueIdentifier.gotoList, sender: nil)
//        return moveToNextByFunc()
//    }
    
    func cancelButton() {
        dismiss(animated: true, completion: nil)
    }
}
