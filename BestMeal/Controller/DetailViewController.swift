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
    
    
    var url = [String]()
    var name = [String]()
    var imageURLString =  [String]()
    var tel =  [String]()
    var information = [DataOnTheCardModel]()
    
    var finalUrl = String()
    var finalName = String()
    var finalImage = String()
    var finalTel = String()
    var indexNumber = Int()
    
    var userPass = String()
    var userEmail = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("URLが\(url.count)個入っています")

        //finalImageには最初に選定したピザ屋の情報しか表示されない（一つしか受け付けていない状態）
        //finalUrlも同様に一つしか受け付けていない状態
        changeType()
        detailImageView.sd_setImage(with: URL(string: finalImage), completed: nil)
        let request = URLRequest(url: (URL(string:finalUrl)!))
        webKit.load(request)
        
        designBackButton.tintColor = UIColor.flatGray()
    }
    
    @IBAction func telButton(sender: Any) {
        UIApplication.shared.open(URL(string: "tel://\(tel)")!, options: [:], completionHandler: nil)
    }
    @IBAction func backButton(sender:UIButton){
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func changeType(){
        
        for i in 0...url.count {
            
        }
        
//        let dataOnTheCard = DataOnTheCardModel(nameOnTheCard: name[indexNumber], imageOnTheCard: imageURLString[indexNumber], userPass: userPass, userEmail: userEmail, telOnTheCard: tel[indexNumber], urlInfoOnTheCard: url[indexNumber])
                
//        finalUrl.append(url[indexNumber])
//        finalTel.append(tel[indexNumber])
//        finalName.append(name[indexNumber])
//        finalImage.append(imageURLString[indexNumber])
        
        
//        if finalImage != "" && finalName != "" && finalTel != "" && finalUrl != "" {
//
//            for _ in 0...finalImage.count/finalTel.count/finalName.count/finalUrl.count {
//                let thisImage = finalImage[indexNumber]
//                let thisUrl = finalUrl[indexNumber]
//                let thisName = finalName[indexNumber]
//                let thisTel = finalTel[indexNumber]
//
//                finalImage = thisImage
//                finalName = thisName
//                finalTel = thisTel
//                finalUrl = thisUrl
//
//            }
//        }
//    }

    }

}
