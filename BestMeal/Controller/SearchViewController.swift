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

@available(iOS 14.0, *)
class SearchViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, DoneCatchProtocol, UITextFieldDelegate {
    
    var idoValue = Double()
    var keidoValue = Double()
    var totalHitCount = Int()
    var userEmail = String()
    var userPass = String()
    var shopDataArray = [ShopData]()
    var dbRf = Database.database().reference()
    var placeDataModelArray = [PlaceDataModel]()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView?.delegate = self
            mapView?.mapType = .standard
            mapView?.userTrackingMode = .follow
        }
    }
    
    @IBOutlet weak var searchBackImage: UIImageView! {
        didSet {
            searchBackImage.image = UIImage(named: ImageName.searchTextBackImage)
            searchBackImage.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: UserDefaultForKey.userPass) != nil {
            userPass = (UserDefaults.standard.object(forKey: UserDefaultForKey.userPass) as? String)!
        }
        let searchImage = UIImage(named: ImageName.searchBackImage)
        self.searchButton.setImage(searchImage, for: .normal)
        view.backgroundColor = .systemGreen
        startUpdatingLocation()
        configureSubview()
        
        if UserDefaults.standard.object(forKey: UserDefaultForKey.placeDatas) != nil {
//            placeDatas = UserDefaults.standard.object(forKey:  UserDefaultForKey.placeDatas) as! [String]
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchTextField.resignFirstResponder()
    }
    
    func startUpdatingLocation() {
        locationManager.requestAlwaysAuthorization()
        let status = CLAccuracyAuthorization.fullAccuracy
        if status == .fullAccuracy {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization() {
        let location = LocationPermission()
        location.locationManagerDidChange(manager: locationManager)
        self.locationManagerDidChangeAuthorization()
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
    
    @IBAction func searchButton (sender: UIButton) {
        
        if UserDefaults.standard.object(forKey: UserDefaultForKey.placeDatas ) != nil {
//            placeDatas = UserDefaults.standard.object(forKey: UserDefaultForKey.placeDatas) as! [String]
        }
        
        if searchTextField.text?.isEmpty == true {
            noKeyWordsAlert()
            return
        }
        searchTextField.resignFirstResponder()
        let urlString =  "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=\(ApiKey.apiKey)&latitude=\(idoValue)&longitude=\(keidoValue)&range=3&hit_per_page=15&freeword=\(searchTextField.text!)"
        let analyticsModel = AnalyticsModel(latitude: idoValue, longitude: keidoValue, url: urlString)
        analyticsModel.doneCatchDataProtocol = self
        analyticsModel.analyizeWithJSON()
    }
    
    func addAnnotation(shopData: [ShopData]) {
        removeArray()
        if totalHitCount == Numbers.smallestNumber {
            mainAlert()
            return
        }
        
        // shopDataからshopDataArrayへ変更
        for each in 0...totalHitCount - 1 {
            print(each)
        var annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(shopDataArray[each].latitude)!, CLLocationDegrees(shopDataArray[each].longitude)!)
            annotation.title = shopDataArray[each].name
            annotation.subtitle = shopData[each].tel
            FetchAllDatas.urlInfos.append(shopData[each].url)
            FetchAllDatas.imageUrlStringInfos.append(shopData[each].shopImage)
            FetchAllDatas.nameInfos.append(shopData[each].name)
            FetchAllDatas.telInfos.append(shopData[each].tel)
            mapView.addAnnotation(annotation)
        }
        searchTextField.resignFirstResponder()
    }
    
    func removeArray() {
        mapView.removeAnnotations(mapView.annotations)
        FetchAllDatas.urlInfos = []
        FetchAllDatas.imageUrlStringInfos = []
        FetchAllDatas.nameInfos = []
        FetchAllDatas.telInfos = []
    }
    
    func catchProtocol (arrayData: Array<ShopData>, resultCount: Int) {
        shopDataArray = arrayData
        totalHitCount = resultCount
        addAnnotation(shopData: shopDataArray)
        performSegue(withIdentifier: SegueIdentifier.toCards, sender: nil)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        var indexNumber = Int()
        if FetchAllDatas.nameInfos.firstIndex(of: (view.annotation?.title)!!) != nil {
            indexNumber = FetchAllDatas.nameInfos.firstIndex(of: (view.annotation?.title)!!)!
        }
        performSegue(withIdentifier: SegueIdentifier.toCards, sender: nil)
    }
    
    @IBAction func didTapAcessListButton(_ sender: UIButton) {
        let listVC = storyboard?.instantiateViewController(identifier: SegueIdentifier.toList) as? FavoritePlaceListViewController
        self.navigationController?.pushViewController(listVC!, animated: true)
    }
}

