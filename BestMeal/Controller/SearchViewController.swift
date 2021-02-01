//
//  SearchViewController.swift
//  BestMeal
//
//Created by Owner on 2020/12/12.

import UIKit
import MapKit
import Lottie
import SwiftyJSON
import ChameleonFramework
import Firebase
import FirebaseFirestore

class SearchViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, DoneCatchProtocol, UITextFieldDelegate{
    
    @IBOutlet weak var searchTextField:UITextField!
    @IBOutlet weak var mapView:MKMapView!
    
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
    //var saveDataOnTheList = [PlaceDataModel]()
    var smallestNumber = 0
    
    var userEmail = String()
    var userPass = String()
    
    var db = Database.database().reference()
    var placeDataModelArray = [PlaceDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "userPass") != nil {
            userPass = UserDefaults.standard.object(forKey: "userPass") as! String
        }
        
        mapView?.delegate = self
        view.backgroundColor = .systemGreen
        startUpdatingLocation()
        configureSubview()
        
        //        if UserDefaults.standard.object(forKey: "userEmail") != nil && UserDefaults.standard.object(forKey: "userPass") != nil {
        //            userEmail = UserDefaults.standard.object(forKey: "userEmail") as! String
        //            userPass = UserDefaults.standard.object(forKey: "userPass") as! String
        //        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchTextField.resignFirstResponder()
    }
    
    func startUpdatingLocation(){
        locationManager.requestAlwaysAuthorization()
        let status = CLAccuracyAuthorization.fullAccuracy
        if status == .fullAccuracy {
            locationManager.startUpdatingLocation()
        }
    }
    
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
    
    func configureSubview(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        
        mapView?.delegate = self
        mapView?.mapType = .standard
        mapView?.userTrackingMode = .follow
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        idoValue = latitude!
        keidoValue = longitude!
    }
    
    @IBAction func searchButton(sender:UIButton){
        if searchTextField.text?.isEmpty == true {
            
            let UIAlert = UIAlertController(title: "検索できません。", message: "キーワードを入れてください！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
                print("OK")
            }
            UIAlert.addAction(okAction)
            present(UIAlert, animated: true, completion: nil)
            return }
        
        searchTextField.resignFirstResponder()
        let urlString =  "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=\(apikey)&latitude=\(idoValue)&longitude=\(keidoValue)&range=3&hit_per_page=15&freeword=\(searchTextField.text!)"
        
        let analyticsModel = AnalyticsModel(latitude: idoValue, longitude: keidoValue, url:urlString)
        
        analyticsModel.doneCatchDataProtocol = self
        analyticsModel.analyizeWithJSON()
    }
    
    func addAnnotation(shopData:[ShopData]){
        removeArray()
        if totalHitCount == smallestNumber {
            alert()
            return
        }
        
        for i in 0...totalHitCount - 1{
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
        
        if segue.identifier == "toCards"{
        
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
    
    func alert(){
        let noInfoAlert:UIAlertController = UIAlertController(title: "情報を取得できません🙇‍♂️", message: "違うキーワードで検索してください！", preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
            print("OK")
        })
        noInfoAlert.addAction(okAction)
        present(noInfoAlert, animated: true, completion: nil)
    }
    
    @IBAction func didTapAcessListButton(_ sender: Any) {
        let listVC = storyboard?.instantiateViewController(identifier: "toList") as! FavoritePlaceListViewController
        self.navigationController?.pushViewController(listVC, animated: true)
    }
}
