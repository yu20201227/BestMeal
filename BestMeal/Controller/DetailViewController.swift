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
    //↑しっかりと右スワイプされた数の情報が入っている
    
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
    
        //finalImageには最初に選定したピザ屋の情報しか表示されない（一つしか受け付けていない状態）
        //finalUrlも同様に一つしか受け付けていない状態
            
        
       detailImageView.sd_setImage(with: URL(string: imageURLString), completed: nil)
        let request = URLRequest(url: (URL(string:url)!))
        webKit.load(request)
        
        designBackButton.tintColor = UIColor.flatGray()
    }
    
    @IBAction func didTapTelButton(sender: Any) {
        UIApplication.shared.open(URL(string: "tel://\(tel)")!, options: [:], completionHandler: nil)
    }
    @IBAction func didTApGoBackButton(sender:UIButton){
        dismiss(animated: true, completion: nil)
    }
}

