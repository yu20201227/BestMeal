//
//  SearchViewPresenter.swift
//  BestMeal
//
//  Created by Owner on 2021/06/05.
//

import Foundation

/// ユーザーの検索ボタンタップ時
/// 検索開始
/// 検索終了しスワイプ画面へ遷移
enum SearchScreenActionFlow {
    case didTapSearchButton
    case startSearching
    case gotoCardSwipeScreen
}

protocol SearchViewPresenterProtocol {
    var searchView: SearchViewProtocol? { get set }
    var interactor: SearchInteractorInputProtocol? { get set }
    func onSearchingButtonTapped()
}

class SearchViewPresenter: SearchViewPresenterProtocol {

    var searchView: SearchViewProtocol?
    var interactor: SearchInteractorInputProtocol?
    
    func onSearchingButtonTapped() {
        self.interactor?.startSearching()
    }

}
