//
//  SearchViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//There is no indicator...

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
    var annotation = MKPointAnnotation()
    
    var idoValue = Double()
    var keidoValue = Double()
    var apikey = "d88dcf59b664fa3f9b089ed353977965"
    var totalHitCount = Int()
    var indexNumber = Int()
    var shopDataArray = [ShopData]()
    
    var nameStringArray = [String]()
    var urlStringArray = [String]()
    var imageStringArray = [String]()
    var telArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        startUpdatingLocation()
        configureSubview()
        
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
        //boot AnalyticdModel
        analyticsModel.doneCatchDataProtocol = self
        analyticsModel.analyizeWithJSON()
        
        performSegue(withIdentifier: "toCards", sender: nil)

    }
    
    func addAnnotation(shopData:[ShopData]){
        removeArray()

        for i in 0...totalHitCount - 1 {
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
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        indexNumber = Int()

        if nameStringArray.firstIndex(of: (view.annotation?.title)!!) != nil {
            indexNumber = nameStringArray.firstIndex(of: (view.annotation?.title)!!)!
        }
        performSegue(withIdentifier: "toCards", sender: nil)
    }
    

    //それぞれのArrayの後に[indexNumber]をつける
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cardVC = segue.destination as! CardSwipeViewController
        cardVC.urlInfos = urlStringArray
        cardVC.nameInfos = nameStringArray
        cardVC.imageUrlStringInfos = imageStringArray
        cardVC.telInfos = telArray
        
        
    }
    
}

//
//  ListViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

//import UIKit
//import Firebase
//import SDWebImage
//import PKHUD
//
//class NameListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
//
//
//    @IBOutlet weak var tableView:UITableView!
//
//    var listRef = Database.database().reference()
//    var getUserIdDataArray = [GetUserInfoToMakeOriginalList]()
//    var indexNumber = Int()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        HUD.show(.progress)
//
//        listRef.child("profile").observe(.value) { (snapshot) in
//            HUD.hide()
//
//            self.getUserIdDataArray.removeAll()
//
//            //childrenは階層になっているデータ本体
//            for child in snapshot.children {
//
//                let childSnapShot = child as! DataSnapshot
//                let listData = GetUserInfoToMakeOriginalList(snapShot:childSnapShot)
//                self.getUserIdDataArray.insert(listData, at: 0)
//                self.tableView.reloadData()
//            }
//        }
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return getUserIdDataArray.count
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 225
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.selectionStyle = .none
//
//        let listDataModel = getUserIdDataArray[indexPath.row]
//        let userNameLabel = cell.contentView.viewWithTag(1) as! UILabel
//        userNameLabel.text = "\(String(describing: listDataModel.userEmail))'s List"
//
//        return cell
//
//    }
//
//
//
//}
//
