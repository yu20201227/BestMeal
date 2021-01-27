//
//  FavoritePlaceListViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import UIKit
import SDWebImage
import FirebaseFirestore
import Firebase

class FavoritePlaceListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate{
    
    @IBOutlet weak var favTableView:UITableView!
    
    //var onTheCardDataArray = [SaveListData]()
    var listName = [String]()
    var listUrl = [String]()
    var listImage = [String]()
    var listTel = [String]()
    var userEmail = String()
    var userPass = String()
    //var favRef = Database.database().reference()
    var indexNumber = Int()
    let db = Firestore.firestore().collection("placeData")
    var dataSets = [PlaceDataModel]()
    
    var indexName = String()
    var indexImage = String()
    var indexUrl = String()
    var indexTel = String()
    
    var loadDBModel = LoadDBModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        favTableView.backgroundColor = .brown
        print("\(listName)これがlistNameです")
        
        favTableView.allowsSelection = true
        
        if UserDefaults.standard.object(forKey: "userPass") != nil{
            userPass = UserDefaults.standard.object(forKey: "userPass") as! String
        }
        
        if UserDefaults.standard.object(forKey: "userName") != nil{
            userEmail = UserDefaults.standard.object(forKey: "userEmail") as! String
            
            self.title = "\(userEmail)'s MusicList"
        }
        favTableView.delegate = self
        favTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "\(userEmail)'s MusicList"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.favTableView.reloadData()
        //loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listName.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .brown
        
        indexName = listName[indexPath.row]
        indexImage = listImage[indexPath.row]
        indexUrl = listUrl[indexPath.row]
        //indexTel = listTel[indexPath.row]
        
        let placeImageViewOnTheList = cell.contentView.viewWithTag(1) as! UIImageView
        //   placeImageViewOnTheList.sd_setImage(with: URL(string: loadDBModel.dataSets[indexPath.row].placeImage), completed: nil)
        
        let placeNameLabelOnTheList = cell.contentView.viewWithTag(2) as! UILabel
        placeNameLabelOnTheList.text = indexName
        //  placeNameLabelOnTheList.text = loadDBModel.dataSets[indexPath.row].placeName
        
        placeNameLabelOnTheList.textColor = .white
        placeNameLabelOnTheList.textAlignment = .center
        placeNameLabelOnTheList.layer.cornerRadius = 10.0
        
        placeImageViewOnTheList.sd_setImage(with: URL(string: indexImage), placeholderImage: UIImage(named: "noImage"), options: .continueInBackground, progress: nil, completed: nil)
        placeImageViewOnTheList.layer.cornerRadius = 20.0
        return cell
        
        let fo = ["placeName":listName[indexPath.row],"placeUrl":listUrl[indexPath.row], "placeImage":listImage[indexPath.row]] as [String : Any]
        db.document().setData(fo)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            listUrl.remove(at: indexPath.row)
            listName.remove(at: indexPath.row)
            listImage.remove(at: indexPath.row)
            listTel.remove(at: indexPath.row)
            favTableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func toDetailScreen(){
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UIApplication.shared.canOpenURL(URL(string: listUrl[indexPath.row])!){
            UIApplication.shared.open(URL(string: listUrl[indexPath.row])!)
        }
        //performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    
    @IBAction func didTapGoBackButton(sender:UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    func uploadDataToFireStore(){
        
        var ref:DocumentReference? = nil
        var refs:CollectionReference? = nil
        
        ref = db.document()
        ref?.setData(["placeUrl" : indexUrl,
                      "placeName": indexName,
                      "placeImage": indexImage
        ]) {  error in
            if let error = error {
                print("エラーが発生しています")
            } else {
                print("good")
            }
        }
        
    }
    
}
