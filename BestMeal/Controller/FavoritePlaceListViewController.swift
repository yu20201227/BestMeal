//
//  FavoritePlaceListViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//リファクタリング中

import UIKit
import Firebase
import SDWebImage
import PKHUD

class FavoritePlaceListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var favTableView:UITableView!
    
    
    var listName = [String]()
    var listUrl = [String]()
    var listImage = [String]()
    var listTel = [String]()
    var userEmail = String()
    var userPass = String()
    var favRef = Database.database().reference()
    var indexNumber = Int()
    
    var indexName = String()
    var indexImage = String()
    var indexUrl = String()
    var indexTel = String()
    
    var data = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favTableView.allowsSelection = true
//
//        if UserDefaults.standard.object(forKey: "userPass") != nil{
//            userPass = UserDefaults.standard.object(forKey: "userPass") as! String
//        }
//
//        if UserDefaults.standard.object(forKey: "userName") != nil{
//            userEmail = UserDefaults.standard.object(forKey: "userEmail") as! String
//
//            self.title = "\(userEmail)'s MusicList"
//        }
                
                
        favTableView.delegate = self
        favTableView.dataSource = self
      //  favTableView.backgroundColor = .black
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
        
        self.title = "\(userEmail)'s MusicList"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.favTableView.reloadData()
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
        
        //右にスワイプした分だけ繰り返し
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //listName&listImageをそのまま反映させたことによりクリア
        indexName = listName[indexPath.row]
        indexImage = listImage[indexPath.row]
        indexUrl = listUrl[indexPath.row]
        indexTel = listTel[indexPath.row]
        
        let userDefault = UserDefaults.standard

        //直接UIImageViewやUILabelに代入できないのか
        let placeImageViewOnTheList = cell.contentView.viewWithTag(1) as! UIImageView
        let placeNameLabelOnTheList = cell.contentView.viewWithTag(2) as! UILabel
        placeNameLabelOnTheList.text = indexName
     
        
        placeImageViewOnTheList.sd_setImage(with: URL(string: indexImage), placeholderImage: UIImage(named: "noImage"), options: .continueInBackground, progress: nil, completed: nil)
        
        //        data.append(indexName)
        //        data.append(indexImage)
        //        favTableView.reloadData()
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //削除する前にアラートを出したい
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            //indexImage.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with:.automatic)
        }
    }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //performSegue(withIdentifier: "toDetail", sender: nil)
            indexUrl = listUrl[indexPath.row]
            let indexUrls = URL(string: indexUrl)
            if UIApplication.shared.canOpenURL(indexUrls! as URL) {
                UIApplication.shared.open(indexUrls! as URL, options: [:], completionHandler: nil)
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        // index（右辺）にはそれぞれ複数情報が取得できている。
        detailVC.url = indexUrl
        detailVC.tel = indexTel
        detailVC.name = indexName
        detailVC.imageURLString = indexImage
    }
    
    @IBAction func didTapGoBackButton(sender:UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    
}
//リストに反映されている情報が、右スワイプした情報と一つづつずれている（一つ下のカード情報がリストに反映される）
