//
//  SearchInteractor.swift
//  BestMeal
//
//  Created by Owner on 2021/06/05.
//

import UIKit

protocol SearchInteractorInputProtocol {
    var presenter: SearchInteractorOutputProtocol? { get set }
    func startSearching()
}

protocol SearchInteractorOutputProtocol {
    func didFetchDatas()
}

class SearchInteractor: UIViewController, SearchInteractorInputProtocol, SearchInteractorOutputProtocol {
    func startSearching() {
    }
    
    
    var presenter: SearchInteractorOutputProtocol?
    
    func didFetchDatas() {
        
    }
    
    
}
