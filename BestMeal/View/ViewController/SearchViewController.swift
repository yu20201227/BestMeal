//
//  SearchViewController.swift
//  BestMeal
//
// Created by Owner on 2020/12/12.

import UIKit
import MapKit
import SwiftyJSON
import RxSwift
import RxCocoa

enum ActionButtonType {
    case search // 店舗検索開始
    case placeList // 店舗一覧リスト
}

protocol searchActionStatusProtocol {
    func doAction()
}

protocol SearchViewProtocol {
    var presenter: SearchViewPresenter? { get set }
}

final class SearchViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate,CLLocationManagerDelegate, DoneCatchProtocol, showAlertProtocol {
    
    private var idoValue = Double()
    private var keidoValue = Double()
    private var totalHitCount = Int()
    private let locationManager = CLLocationManager()
    private let disposeBag = DisposeBag()
    
    private(set) var shopDataArray = [ShopData]()
    private var presenter: SearchPresenter = SearchViewPresenter()
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var mapView: MKMapView?
    @IBOutlet private weak var searchBackImage: UIImageView!
    @IBOutlet private weak var searchButton: UIButton!
    
    // リストへのアクセスボタン
    // @IBOutlet private weak var goToListButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView?.delegate = self
        mapView?.mapType = .standard
        mapView?.userTrackingMode = .follow
        searchBackImage.image = R.image.zoom_saga()
        searchBackImage.contentMode = .scaleAspectFill
        searchButton.imageView?.image = R.image.search()
        
        view.backgroundColor = .systemGreen
        startUpdatingLocation()
        configureSubview()
        
        _ = self.searchButton.rx.tap.subscribe(onNext: {[unowned self] _ in
            self.judgeActionButtonType(actionType: .search)
        }).disposed(by: disposeBag)
        
        // リスト画面へ遷移するためのアクション購読
//        _ = self.goToListButton.rx.tap.subscribe(onNext: { [unowned self] _ in
//            self.setEnumStatusAction(searchStatus: .gotoList)
//        }).disposed(by: disposeBag)
    }

    private func judgeActionButtonType(actionType: ActionButtonType) {
        switch actionType {
        case .search:
            self.startSearching()
        case .placeList:
            self.didTapAccessPlaceList()
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchTextField.resignFirstResponder()
    }
    
    private func searchLocation(latitude: Double, longitude: Double) {
        idoValue = latitude
        keidoValue = longitude
    }
    
    private func startUpdatingLocation() {
        locationManager.requestAlwaysAuthorization()
        let status = CLAccuracyAuthorization.fullAccuracy
        if status == .fullAccuracy {
            locationManager.startUpdatingLocation()
        }
    }
    
    internal func locationManager (_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        idoValue = latitude!
        keidoValue = longitude!
    }
    
    private func configureSubview() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
    }
    
    func addAnnotation(shopData: [ShopData]) {
        
        mapView!.removeAnnotations(mapView!.annotations)
        
        // MARK: - 下記の記述（1行）にまとめられるのではないか。
        //  FetchAllDatas.AllCases = []
        FetchAllDatas.urlInfos = []
        FetchAllDatas.imageUrlStringInfos = []
        FetchAllDatas.nameInfos = []
        FetchAllDatas.telInfos = []
        if totalHitCount == Numbers.smallestNumber {
            return mainAlert()
        }
        
        for each in 0...totalHitCount - 1 {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(shopDataArray[each].latitude)!, (CLLocationDegrees(shopDataArray[each].longitude))!)
            annotation.title = shopDataArray[each].name
            annotation.subtitle = shopData[each].tel
            FetchAllDatas.urlInfos.append(shopData[each].url)
            FetchAllDatas.imageUrlStringInfos.append(shopData[each].shopImage)
            FetchAllDatas.nameInfos.append(shopData[each].name)
            FetchAllDatas.telInfos.append(shopData[each].tel)
            
            mapView?.addAnnotation(annotation)
        }
        searchTextField.resignFirstResponder()
    }
    
    func catchProtocol (arrayData: Array<ShopData>, resultCount: Int) {
        shopDataArray = arrayData
        totalHitCount = resultCount
        addAnnotation(shopData: shopDataArray)
        // 画面遷移
        self.presenter.gotoCardSwipeScreen(self)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if FetchAllDatas.nameInfos.firstIndex(of: (view.annotation?.title)!!) != nil {
            _ = FetchAllDatas.nameInfos.firstIndex(of: (view.annotation?.title)!!)!
        }
        performSegue(withIdentifier: SegueIdentifier.toCards, sender: nil)
    }
    
    private func didTapAccessPlaceList() {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "FavoritePlaceListViewController") as! FavoritePlaceListViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    private func startSearching() {
        if searchTextField.text?.isEmpty == true {
            noKeyWordsAlert()
        }
        searchTextField.resignFirstResponder()

        let urlString =   "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=\(ApiKey.apiKey)&latitude=\(idoValue)&longitude=\(keidoValue)&range=3&hit_per_page=15&freeword=\(searchTextField.text!)"
        
        let analyticsModel = AnalyticsModel(latitude: idoValue, longitude: keidoValue, url: urlString)
        analyticsModel.doneCatchDataProtocol = self
        analyticsModel.analyizeWithJSON()
    }
    
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.presenter.locationManagerDidChangeAuthorization(manager)
    }
}
