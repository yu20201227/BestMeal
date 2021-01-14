//
//  DetailViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import UIKit
import WebKit
import SDWebImage
import ChameleonFramework
import DTGradientButton

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var webKit: WKWebView!
    @IBOutlet weak var designBackButton:UIButton!
    
    var url = String()
    var name = String()
    var imageURLString = String()
    var tel =  String()
    var index = Int()

//    var information = [DataOnTheCardModel]()
//    var finalUrl = [String]()
//    var finalName = String()
//    var finalImage = [String]()
//    var finalTel = String()
//    var indexNumber = Int()
    //↑ここも順番に情報取得ができている
    
    var userPass = String()
    var userEmail = String()

    let favoriteView = FavoritePlaceListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //表示されませんでした。
        let listImages = favoriteView.listImage
        
        for i in  listImages {
            let iImage = i
        
       detailImageView.sd_setImage(with: URL(string: iImage), completed: nil)
        let request = URLRequest(url: (URL(string:url)!))
        webKit.load(request)
        
        designBackButton.tintColor = UIColor.flatGray()
    }
    }
    
    @IBAction func telButton(sender: Any) {
        UIApplication.shared.open(URL(string: "tel://\(tel)")!, options: [:], completionHandler: nil)
    }
    @IBAction func backButton(sender:UIButton){
        dismiss(animated: true, completion: nil)
        
    
    }    
}

