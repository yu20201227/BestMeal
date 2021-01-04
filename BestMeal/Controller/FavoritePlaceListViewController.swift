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
    @IBOutlet weak var toDetailUIButton:UIButton!
    
    
    
  //  var onTheCardDataArray = [DataOnTheCardModel]()
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let detailVC = DetailViewController()
        //listName&listImageをそのまま反映させたことによりクリア
        indexName = listName[indexPath.row]
        indexImage = listImage[indexPath.row]
        indexUrl = listUrl[indexPath.row]
        indexTel = listTel[indexPath.row]
        
        //直接UIImageViewやUILabelに代入できないのか
        let placeImageViewOnTheList = cell.contentView.viewWithTag(1) as! UIImageView
        let placeNameLabelOnTheList = cell.contentView.viewWithTag(2) as! UILabel
        var searchButton = cell.contentView.viewWithTag(3)
        placeNameLabelOnTheList.text = indexName
        
        placeImageViewOnTheList.sd_setImage(with: URL(string: indexImage), placeholderImage: UIImage(named: "noImage"), options: .continueInBackground, progress: nil, completed: nil)
                
       // toDetailUIButton = listUrl[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            //self.onTheCardDataArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with:.automatic)
        }
    }
    
    func toDetailScreen(){
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    func showAlert(){
        
        let alertController = UIAlertController(title: "選択", message: "詳細を開きますか？", preferredStyle: .actionSheet)
        let toDetailInfo = UIAlertAction(title: "詳細を開く", style: .default) { (alert) in
            self.toDetailScreen()
        }
        let toCancel = UIAlertAction(title: "キャンセル", style: .cancel)
        
        alertController.addAction(toDetailInfo)
        alertController.addAction(toCancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func tapImage(_ sender: UITapGestureRecognizer)
    {
        self.showAlert()
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //performSegue(withIdentifier: "toDetail", sender: nil)
            indexUrl = listUrl[indexPath.row]
            let indexUrls = URL(string: indexUrl)
            if UIApplication.shared.canOpenURL(indexUrls! as URL) {
                UIApplication.shared.open(indexUrls! as URL, options: [:], completionHandler: nil)
            }
            
            
//            if UIApplication.shared.canOpenURL(indexUrls!) {
//                UIApplication.shared.open(indexUrls!)
//            }
            
        }
//
//    @IBAction func toDetailButton(sender: UIButton){
//        performSegue(withIdentifier: "toDetail", sender: nil)
//        let url = URL(string: indexUrl)
//        if UIApplication.shared.canOpenURL(url!){
//            UIApplication.shared.open(url!)
//
////            indexName = ""
////            indexImage = ""
////            indexUrl = ""
////            indexTel = ""
//
//
//        }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
       // index（右辺）にはそれぞれ複数情報が取得できている。
        detailVC.url = indexUrl
        detailVC.tel = indexTel
        detailVC.name = indexName
        detailVC.imageURLString = indexImage


    }
    
}
    
//カードに表示されているものは正しくlistへ遷移される？？
    


