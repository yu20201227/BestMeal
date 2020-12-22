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
    var listName = [String]()
    var listUrl = [String]()
    var listImage = [String]()
    var listTel = [String]()
    var userEmail = String()
    var userPass = String()
    var favRef = Database.database().reference()
    var indexNumber = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("listImageには\(listImage.count)個入っています。これが右にすワイプした数と比例していること")
        
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        HUD.show(.progress)
        
        favRef.child("users").child("userEmail").observe(.value) { (snapshot) in
            
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
        return listName.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
        
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cardData = onTheCardDataArray[indexPath.row]
        
        let placeImageViewOnTheList = cell.contentView.viewWithTag(1) as! UIImageView
        let placeNameLabelOnTheList = cell.contentView.viewWithTag(2) as! UILabel
        //let placeUrlLabel = cell.contentView.viewWithTag(3) as! UILabel
        placeNameLabelOnTheList.text =  cardData.nameOnTheCard
        //placeUrlLabel.text = cardData.urlInfoOnTheCard
        
        placeImageViewOnTheList.sd_setImage(with: URL(string: cardData.imageOnTheCard), placeholderImage: UIImage(named: "noImage"), options: .continueInBackground, progress: nil, completed: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            self.onTheCardDataArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with:.automatic)
        }
    }
    
//    func toDetailScreen(){
//        performSegue(withIdentifier: "toDetail", sender: nil)
//    }
//
//    func showAlert(){
//
//        let alertController = UIAlertController(title: "選択", message: "詳細を開きますか？", preferredStyle: .actionSheet)
//        let toDetailInfo = UIAlertAction(title: "詳細を開く", style: .default) { (alert) in
//            self.toDetailScreen()
//        }
//        let toCancel = UIAlertAction(title: "キャンセル", style: .cancel)
//
//            alertController.addAction(toDetailInfo)
//            alertController.addAction(toCancel)
//        self.present(alertController, animated: true, completion: nil)
//        }
//
//
//    @IBAction func tapImage(_ sender: UITapGestureRecognizer)
//    {
//        self.showAlert()
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _ = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
    }
    
    @IBAction func toDetailButton(sender: UIButton){
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    //元：self.listName...
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        detailVC.url = [listUrl[indexNumber]]
        print("[\(listUrl)]これがURLだよ！！！！！！！！！")
        detailVC.name = [listName[indexNumber]]
        detailVC.tel = [listTel[indexNumber]]
        detailVC.imageURLString = [listImage[indexNumber]]
        //present(detailVC, animated: true, completion: nil)
    }
}

    

