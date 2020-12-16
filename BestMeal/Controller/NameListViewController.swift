//
//  ListViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import UIKit
import Firebase
import SDWebImage
import PKHUD

class NameListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var tableView:UITableView!
    
    var listRef = Database.database().reference()
    var getUserIdDataArray = [GetUserInfoToMakeOriginalList]()
    var indexNumber = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        HUD.show(.progress)
        
        listRef.child("profile").observe(.value) { (snapshot) in
            HUD.hide()
            
            self.getUserIdDataArray.removeAll()
            
            //childrenは階層になっているデータ本体
            for child in snapshot.children {
                
                let childSnapShot = child as! DataSnapshot
                let listData = GetUserInfoToMakeOriginalList(snapShot:childSnapShot)
                self.getUserIdDataArray.insert(listData, at: 0)
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getUserIdDataArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        
        let listDataModel = getUserIdDataArray[indexPath.row]
        let userNameLabel = cell.contentView.viewWithTag(1) as! UILabel
        userNameLabel.text = "\(String(describing: listDataModel.userName))'s List"
        
        return cell
        
    }
    


}
