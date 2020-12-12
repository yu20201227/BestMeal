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
    
    var onTheCardDataArray = [GetUserInfoToMakeOriginalList]()
    var listName = ""
    var listUrl = ""
    var listImage = ""
    var listTel = ""
    var userName = ""
    var userEmail = ""
    var favRef = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favTableView.allowsSelection = true
        
        
        if UserDefaults.standard.object(forKey: "userEmali") != nil{
            userEmail = UserDefaults.standard.object(forKey: "userEmail") as! String
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
    


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

    

}

