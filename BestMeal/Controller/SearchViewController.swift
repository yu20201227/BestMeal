//
//  SearchViewController.swift
//  BestMeal
//
// Created by Owner on 2020/12/12.

import UIKit
import MapKit
import Lottie
import SwiftyJSON
import ChameleonFramework
import Firebase
// import FirebaseFirestore
// SOLID原則

@available(iOS 13.0, *)
class SearchViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate, DoneCatchProtocol {
    
    var idoValue = Double()
    var keidoValue = Double()
    var totalHitCount = Int()
    var userEmail = String()
    var userPass = String()
    let locationManager = CLLocationManager()
    
    private(set) var shopDataArray = [ShopData]()
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
        }
    }
    
    @IBOutlet weak var mapView: MKMapView? {
        didSet {
            mapView?.delegate = self
            mapView?.mapType = .standard
            mapView?.userTrackingMode = .follow
        }
    }
    
    @IBOutlet weak var searchBackImage: UIImageView! {
        didSet {
            searchBackImage.image = R.image.zoom_saga()
            searchBackImage.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var searchButton: UIButton! {
        didSet {
            searchButton.imageView?.image = R.image.search()
        }
    }
    
    func searchLocation(latitude: Double, longitude: Double) {
        idoValue = latitude
        keidoValue = longitude
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: UserDefaultForKey.userPass) != nil {
            userPass = (UserDefaults.standard.object(forKey: UserDefaultForKey.userPass) as? String)!
        }
        
        view.backgroundColor = .systemGreen
        startUpdatingLocation()
        configureSubview()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchTextField.resignFirstResponder()
    }
    
    private func startUpdatingLocation() {
        locationManager.requestAlwaysAuthorization()
        let status = CLAccuracyAuthorization.fullAccuracy
        if status == .fullAccuracy {
            locationManager.startUpdatingLocation()
        }
    }
    
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("user Permitted")
            break
        case .denied:
            print("user Denied")
            break
        default: print("something error on the location permisssion")
        }
        
        switch manager.accuracyAuthorization {
        case .reducedAccuracy, .fullAccuracy: break
        default: print("something wrong")
        }
    }
    
    func configureSubview() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
    }
    
    func locationManager (_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        idoValue = latitude!
        keidoValue = longitude!
    }
    
    @IBAction func searchButton (_ sender: UIButton) {
        if UserDefaults.standard.object(forKey: UserDefaultForKey.placeDatas ) != nil {
            //            placeDatas = UserDefaults.standard.object(forKey: UserDefaultForKey.placeDatas) as! [String]
        }
        startSearching()
    }
    
    func addAnnotation(shopData: [ShopData]) {
        
        mapView!.removeAnnotations(mapView!.annotations)
        FetchAllDatas.urlInfos = []
        FetchAllDatas.imageUrlStringInfos = []
        FetchAllDatas.nameInfos = []
        FetchAllDatas.telInfos = []
        // Numbers.smallestNumber == 0
        if totalHitCount == Numbers.smallestNumber {
            return mainAlert()
        }
        
        for each in 0...totalHitCount - 1 {
            print(each)
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
        performSegue(withIdentifier: SegueIdentifier.toCards, sender: nil)
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
    
    func startSearching() {
        if searchTextField.text?.isEmpty == true {
            noKeyWordsAlert()
            return
        }
        searchTextField.resignFirstResponder()
            let urlString =   "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=\(ApiKey.apiKey)&latitude=\(idoValue)&longitude=\(keidoValue)&range=3&hit_per_page=15&freeword=\(searchTextField.text!)"

        let analyticsModel = AnalyticsModel(latitude: idoValue, longitude: keidoValue, url: urlString)
        analyticsModel.doneCatchDataProtocol = self
        analyticsModel.analyizeWithJSON()
    }
}
