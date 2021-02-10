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
import FirebaseFirestore

class SearchViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, DoneCatchProtocol, UITextFieldDelegate {
    
    let animationView = AnimationView()
    let locationManager = CLLocationManager()
    var annotation = MKPointAnnotation()
    var idoValue = Double()
    var keidoValue = Double()
    let apikey = "d88dcf59b664fa3f9b089ed353977965"
    var totalHitCount = Int()
    var indexNumber = Int()
    var nameStringArray = [String]()
    var urlStringArray = [String]()
    var imageStringArray = [String]()
    var telArray = [String]()
    let smallestNumber = 0
    var userEmail = String()
    var userPass = String()
    var dbRf = Database.database().reference()
    var placeDataModelArray = [PlaceDataModel]()
    var shopDataArray = [ShopData]()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBackImage: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: "userPass") != nil {
            userPass = (UserDefaults.standard.object(forKey: "userPass") as? String)!
        }
        let searchImage = UIImage(named: "search")
        self.searchButton.setImage(searchImage, for: .normal)
        searchBackImage.image = UIImage(named: "zoom_saga")
        searchBackImage.contentMode = .scaleAspectFill
        searchBackImage.alpha = 0.7
        mapView?.delegate = self
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
        mapView?.delegate = self
        mapView?.mapType = .standard
        mapView?.userTrackingMode = .follow
    }
    
    func locationManager (_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        idoValue = latitude!
        keidoValue = longitude!
    }
    
    @IBAction func searchButton (sender: UIButton) {
        if searchTextField.text?.isEmpty == true {
            noKeyWordsAlert()
            return
        }
        searchTextField.resignFirstResponder()
        let urlString =  "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=\(apikey)&latitude=\(idoValue)&longitude=\(keidoValue)&range=3&hit_per_page=15&freeword=\(searchTextField.text!)"
        let analyticsModel = AnalyticsModel(latitude: idoValue, longitude: keidoValue, url: urlString)
        analyticsModel.doneCatchDataProtocol = self
        analyticsModel.analyizeWithJSON()
    }
    
    func addAnnotation(shopData: [ShopData]) {
        removeArray()
        if totalHitCount == smallestNumber {
            mainAlert()
            return
        }
        
        for each in 0...totalHitCount - 1 {
            print(each)
            annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(shopDataArray[each].latitude!)!, CLLocationDegrees(shopDataArray[each].longitude!)!)
            annotation.title = shopData[each].name
            annotation.subtitle = shopData[each].tel
            urlStringArray.append(shopData[each].url!)
            imageStringArray.append(shopData[each].shopImage!)
            nameStringArray.append(shopData[each].name!)
            telArray.append(shopData[each].tel!)
            mapView.addAnnotation(annotation)
        }
        searchTextField.resignFirstResponder()
    }
    
    func removeArray() {
        mapView.removeAnnotations(mapView.annotations)
        urlStringArray = []
        imageStringArray = []
        nameStringArray = []
        telArray = []
    }
    
    func catchProtocol (arrayData: Array<ShopData>, resultCount: Int) {
        shopDataArray = arrayData
        totalHitCount = resultCount
        addAnnotation(shopData: shopDataArray)
        performSegue(withIdentifier: "toCards", sender: nil)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        indexNumber = Int()
        if nameStringArray.firstIndex(of: (view.annotation?.title)!!) != nil {
            indexNumber = nameStringArray.firstIndex(of: (view.annotation?.title)!!)!
        }
        performSegue(withIdentifier: "toCards", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCards" {
            let cardVC = segue.destination as! CardSwipeViewController
            cardVC.urlInfos = urlStringArray
            print("\(urlStringArray)")
            cardVC.nameInfos = nameStringArray
            cardVC.imageUrlStringInfos = imageStringArray
            cardVC.telInfos = telArray
        } else if segue.identifier == "gotoList" {
            performSegue(withIdentifier: "gotoList", sender: nil)
        }
    }
    
    @IBAction func didTapAcessListButton(_ sender: Any) {
        let listVC = storyboard?.instantiateViewController(identifier: "toList") as? FavoritePlaceListViewController
        self.navigationController?.pushViewController(listVC!, animated: true)
    }
}

