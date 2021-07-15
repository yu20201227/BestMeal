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

enum SearchActionStatus {
    case none
    case search
    case gotoList
}

protocol searchActionStatusProtocol {
    func doAction()
}

protocol SearchViewProtocol {
    var presenter: SearchViewPresenter? { get set }
}

class SearchViewController: BaseViewController, MKMapViewDelegate, UITextFieldDelegate,CLLocationManagerDelegate, DoneCatchProtocol, showAlertProtocol {
    
    var idoValue = Double()
    var keidoValue = Double()
    var totalHitCount = Int()
    let locationManager = CLLocationManager()
    var status: SearchActionStatus = .none
    
    private(set) var shopDataArray = [ShopData]()
    private var presenter: SearchPresenter = SearchViewPresenter()
        
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView?
    @IBOutlet weak var searchBackImage: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    
    override func setup() {
        mapView?.delegate = self
        mapView?.mapType = .standard
        mapView?.userTrackingMode = .follow
        searchBackImage.image = R.image.zoom_saga()
        searchBackImage.contentMode = .scaleAspectFill
        searchButton.imageView?.image = R.image.search()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
        setup()
        startUpdatingLocation()
        configureSubview()
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
    
    @IBAction func searchButton (_ sender: UIButton) {
        startSearching()
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
    
    @IBAction func didTapAcessListButton(_ sender: UIButton) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "FavoritePlaceListViewController") as! FavoritePlaceListViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    private func startSearching() {
        status = .search
        if searchTextField.text?.isEmpty == true {
            noKeyWordsAlert()
        }
        searchTextField.resignFirstResponder()

        let urlString =   "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=\(ApiKey.apiKey)&latitude=\(idoValue)&longitude=\(keidoValue)&range=3&hit_per_page=15&freeword=\(searchTextField.text!)"
        
        let analyticsModel = AnalyticsModel(latitude: idoValue, longitude: keidoValue, url: urlString)
        analyticsModel.doneCatchDataProtocol = self
        analyticsModel.analyizeWithJSON()
        status = .gotoList
    }
    
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.presenter.locationManagerDidChangeAuthorization(manager)
    }
}
