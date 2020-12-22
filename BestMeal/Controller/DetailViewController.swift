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
        
//        let dataOnTheCard = DataOnTheCardModel(nameOnTheCard: name[indexNumber], imageOnTheCard: imageURLString[indexNumber], userPass: userPass, userEmail: userEmail, telOnTheCard: tel[indexNumber], urlInfoOnTheCard: url[indexNumber])
                
        finalUrl.append(url[indexNumber])
        finalTel.append(tel[indexNumber])
        finalName.append(name[indexNumber])
        finalImage.append(imageURLString[indexNumber])
        
        if finalImage != "" && finalName != "" && finalTel != "" && finalUrl != "" {

            for _ in 0...imageURLString.count/tel.count/name.count/url.count {
                let thisImage = imageURLString[indexNumber]
                let thisUrl = url[indexNumber]
                let thisName = name[indexNumber]
                let thisTel = tel[indexNumber]

                finalImage = thisImage
                finalName = thisName
                finalTel = thisTel
                finalUrl = thisUrl
                
            }
        }
    }


}
