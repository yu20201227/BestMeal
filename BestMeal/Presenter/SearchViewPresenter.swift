//
//  SearchViewPresenter.swift
//  BestMeal
//
//  Created by Owner on 2021/06/05.
//

import Foundation
import MapKit

/// ユーザーの検索ボタンタップ時
/// 検索開始
/// 検索終了しスワイプ画面へ遷移
enum SearchScreenActionFlow {
    case didTapSearchButton
    case startSearching
    case gotoCardSwipeScreen
}

protocol SearchPresenter {
    func gotoCardSwipeScreen(_ view: SearchViewController)
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager)
    func gotoPlaceListScreen(_ view: SearchViewController)
}

final class SearchViewPresenter: SearchPresenter {
    
    private var interactor: SearchUseCase = SearchInteractor()
    private var router: SearchWireFrame = SearchRouter()
    
    internal func gotoCardSwipeScreen(_ view: SearchViewController) {
        self.router.getCardsToken(view)
    }
    
    func gotoPlaceListScreen(_ view: SearchViewController) {
        self.router.didTapAccessPlaceList(view)
    }
    
}

@available(iOS 14.0, *)
extension SearchViewPresenter {
    
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse: print("user Permitted")
        case .denied: print("user Denied")
        case .notDetermined: print("")
        case .restricted: print("")
            
            switch manager.accuracyAuthorization {
            case .reducedAccuracy, .fullAccuracy:
                print("User chose low Accuracy mode.")
            @unknown default:
                print("Error Happened")
            }
        @unknown default:
            print("")
        }
    }

}
