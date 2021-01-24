//
//  SearchViewController.swift
//  BestMeal
//
//Created by Owner on 2020/12/12.
//There is no indicator...

import UIKit
import MapKit
import Lottie
import SwiftyJSON
import ChameleonFramework
import Firebase
import FirebaseFirestore

class SearchViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, DoneCatchProtocol{
    
    @IBOutlet weak var searchTextField:UITextField!
    @IBOutlet weak var mapView:MKMapView!
    @IBOutlet weak var showAlertUILabel: UILabel!
    
    let animationView = AnimationView()
    let locationManager = CLLocationManager()
    var annotation = MKPointAnnotation()
    
    var idoValue = Double()
    var keidoValue = Double()
    var apikey = "d88dcf59b664fa3f9b089ed353977965"
    var totalHitCount = Int()
    var indexNumber = Int()
    
    var nameStringArray = [String]()
    var urlStringArray = [String]()
    var imageStringArray = [String]()
    var telArray = [String]()
    
    var shopDataArray = [ShopData]()
    var saveDataOnTheList = [PlaceDataModel]()
    let db = Firestore.firestore().collection("placeData")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        view.backgroundColor = .systemGreen
        startUpdatingLocation()
        configureSubview()
        //design
        searchTextField.layer.cornerRadius = 1.0
        mapView.layer.cornerRadius = 1.0
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
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.userTrackingMode = .follow
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        idoValue = latitude!
        keidoValue = longitude!
    }
    
    @IBAction func searchButton(sender:UIButton){
        searchTextField.resignFirstResponder()
        let urlString =  "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=\(apikey)&latitude=\(idoValue)&longitude=\(keidoValue)&range=3&hit_per_page=15&freeword=\(searchTextField.text!)"
       
        let analyticsModel = AnalyticsModel(latitude: idoValue, longitude: keidoValue, url:urlString)
        if analyticsModel.shopDataArray.count == nil {
            self.alert()
            return }
        //boot AnalyticdModel
        analyticsModel.doneCatchDataProtocol = self
        analyticsModel.analyizeWithJSON()
        
        }
    
    func addAnnotation(shopData:[ShopData]){
        removeArray()
        
        for i in 0...totalHitCount - 1{
            //取得アノテーションが1以下だった場合、強制的にリストへ飛ばす
            if totalHitCount <= 1 {
                let listViewController = self.storyboard?.instantiateViewController(identifier: "ListMenu") as! FavoritePlaceListViewController
                self.present(listViewController, animated: true, completion: nil)
            }
            print(i)
            annotation = MKPointAnnotation()

            annotation.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(shopDataArray[i].latitude!)!, CLLocationDegrees(shopDataArray[i].longitude!)!)
            
            annotation.title = shopData[i].name
            annotation.subtitle = shopData[i].tel
            
            urlStringArray.append(shopData[i].url!)
            imageStringArray.append(shopData[i].shop_image!)
            nameStringArray.append(shopData[i].name!)
            telArray.append(shopData[i].tel!)
            mapView.addAnnotation(annotation)
        }
        searchTextField.resignFirstResponder()
    }
    
    func removeArray(){
        mapView.removeAnnotations(mapView.annotations)
        urlStringArray = []
        imageStringArray = []
        nameStringArray = []
        telArray = []
    }
    
    func catchProtocol(arrayData: Array<ShopData>, resultCount: Int) {
        if annotation == nil {
            let listViewController =
                self.storyboard?.instantiateViewController(identifier: "toListMenu") as! FavoritePlaceListViewController
            self.present(listViewController, animated: true, completion: nil)
        }
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
        //↓アノテーションをタップしたらカードに遷移する
        performSegue(withIdentifier: "toCards", sender: nil)
    }
    
    //それぞれのArrayの後に[indexNumber]をつける
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cardVC = segue.destination as! CardSwipeViewController
        cardVC.urlInfos = urlStringArray
        print("\(urlStringArray)")
        cardVC.nameInfos = nameStringArray
        cardVC.imageUrlStringInfos = imageStringArray
        cardVC.telInfos = telArray
    }
    
    func alert(){
        let alert:UIAlertController = UIAlertController(title: "警告", message: "情報を取得できませんでした。", preferredStyle: .alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
            print("OK")
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
