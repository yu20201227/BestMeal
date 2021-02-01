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
    
    var listName = [String]()
    var listUrl = [String]()
    var listImage = [String]()
    var listTel = [String]()
    var userPass = String()
    var indexNumber = Int()
    let db = Database.database().reference()
    
    var indexName = String()
    var indexImage = String()
    var indexUrl = String()
    var indexTel = String()
    
    var placeDataModelArray = [PlaceDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "userPass") != nil {
            userPass = UserDefaults.standard.object(forKey: "userPass") as! String
        }
        
        favTableView.delegate = self
        favTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        db.child("placeData").child(userPass).observe(.value) { (snapshot) in
            self.placeDataModelArray.removeAll()
            
            for child in snapshot.children {
                let childSnapshot = child as! DataSnapshot
                let placeDataMoldels = PlaceDataModel(snapShot: childSnapshot)
                self.placeDataModelArray.insert(placeDataMoldels, at: 0)
                self.favTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if listName.isEmpty {
        return 0
            print("やはりfirebaseは非同期通信だった。")
    } else {
        return listName.count
    }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 160
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = .brown
        
        indexName = listName[indexPath.row]
        indexImage = listImage[indexPath.row]
        indexUrl = listUrl[indexPath.row]
        indexTel = listTel[indexPath.row]
        
        let placeImageViewOnTheList = cell.contentView.viewWithTag(1) as! UIImageView
        let placeNameLabelOnTheList = cell.contentView.viewWithTag(2) as! UILabel
        
        placeNameLabelOnTheList.text = indexName
        placeNameLabelOnTheList.textColor = .white
        placeNameLabelOnTheList.textAlignment = .center
        placeNameLabelOnTheList.layer.cornerRadius = 10.0
 
        
        placeImageViewOnTheList.sd_setImage(with: URL(string: indexImage), placeholderImage: UIImage(named: "noImage"), options: .continueInBackground, progress: nil, completed: nil)
        placeImageViewOnTheList.layer.cornerRadius = 20.0
        
        return cell
        
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
    }
    
    @IBAction func didTapGoBackButton(sender:UIButton){
        dismiss(animated: true, completion: nil)
    }
}
