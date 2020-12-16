//
//  FavoritePlaceListViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import UIKit
import Firebase
import SDWebImage
import PKHUD

class FavoritePlaceListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var favTableView:UITableView!
    
    var onTheCardDataArray = [DataOnTheCardModel]()
    var listName = ""
    var listUrl = ""
    var listImage = ""
    var listTel = ""
    var userName = ""
    var userPass = ""
    var favRef = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favTableView.allowsSelection = true
        
        
        if UserDefaults.standard.object(forKey: "userPass") != nil{
            userPass = UserDefaults.standard.object(forKey: "userPass") as! String
        }

        if UserDefaults.standard.object(forKey: "userName") != nil{
            
            userName = UserDefaults.standard.object(forKey: "userName") as! String
            
            self.title = "\(userName)'s MusicList"
        }
        favTableView.delegate = self
        favTableView.dataSource = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.navigationBar.tintColor = .white
        
        self.title = "\(userName)'s MusicList"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        HUD.show(.progress)
        
        favRef.child("users").child(userName).observe(.value) { (snapshot) in
            
            self.onTheCardDataArray.removeAll()
            
            for child in snapshot.children {
                let childSnapShot = child as! DataSnapshot
                let personalData = DataOnTheCardModel(snapShot: childSnapShot)
                self.onTheCardDataArray.insert(personalData, at: 0)
                self.favTableView.reloadData()
            }
            HUD.hide()
        }
    }
    


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onTheCardDataArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cardData = onTheCardDataArray[indexPath.row]
        
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        let placeNameLabel = cell.contentView.viewWithTag(2) as! UILabel
        let placeUrlLabel = cell.contentView.viewWithTag(3) as! UILabel
        placeNameLabel.text = cardData.nameOnTheCard
        placeUrlLabel.text = cardData.urlInfoOnTheCard
        
        imageView.sd_setImage(with: URL(string: cardData.imageOnTheCard), placeholderImage: UIImage(named: "noImage"), options: .continueInBackground, progress: nil, completed: nil)
        
        return cell
    }

    

}

