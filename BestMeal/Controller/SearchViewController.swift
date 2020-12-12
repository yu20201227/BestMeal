//
//  SearchViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import UIKit
import MapKit
import Lottie
import SwiftyJSON
import Alamofire

class SearchViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, DoneCatchProtocol{
    
    @IBOutlet weak var searchTextField:UITextField!
    @IBOutlet weak var mapView:MKMapView!
    
    let animationView = AnimationView()
    let locationManager = CLLocationManager()
    
    var idoValue = Double()
    var keidoValue = Double()
    var apikey = ""
    var totalHitCount = Int()
    var indexNumber = Int()
    var shopDataArray = [ShopData]()
    
    var nameStringArray = [String]()
    var urlStringArray = [String]()
    var imageStringArray = [String]()
    var telArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func bootIndicator(){
        
    }
    //get permisson of user's current location
    func startUpdatingLocation(){
        locationManager.requestAlwaysAuthorization()
        let status = CLAccuracyAuthorization.fullAccuracy
        
        if status == .fullAccuracy {
            locationManager.startUpdatingLocation()
        }
        
    }
    //user changes the accuracy level of the location.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            break
        default:
            print("error")
        }
        switch manager.accuracyAuthorization {
        case .reducedAccuracy:
            break
        case .fullAccuracy:
            break
        default:
            print("something wrong")
        }
    }
    //boot locationManager/MapView
    func configureSubview(){
        locationManager.delegate = self
        // the highest accuracy possible
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        mapView.mapType = .satellite
        mapView.userTrackingMode = .follow
    }
    @IBAction func searchButton(sender:UIButton){
        searchTextField.resignFirstResponder()
        
        let urlString =  "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=\(apikey)&latitude=\(idoValue)&longitude=\(keidoValue)&range=3&hit_per_page=50&freeword=\(searchTextField.text!)&"
        
        let analyticsModel = AnalyticsModel(latitude: idoValue, longitude: keidoValue, url:urlString)
        //boot AnalyticdModel
        analyticsModel.doneCatchDataProtocol = self
        analyticsModel.analyizeWithJSON()
    }
    
    func catchProtocol(arrayData: Array<ShopData>, resultCount: Int) {
        shopDataArray = arrayData
        totalHitCount = resultCount
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        indexNumber = Int()
        let cardVC = segue.destination as! CardSwipeViewController
        cardVC.urlInfos = urlStringArray[indexNumber]
        cardVC.nameInfos = nameStringArray[indexNumber]
        cardVC.imageUrlStringInfos = imageStringArray[indexNumber]
        cardVC.telInfos = telArray[indexNumber]
        
        
    }
    
}
