//
//  DetailViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import UIKit
import WebKit
import SDWebImage

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailTableView: UIImageView!
    @IBOutlet weak var webKit: WKWebView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeType()
        detailTableView.sd_setImage(with: URL(string: finalImage), completed: nil)
        let request = URLRequest(url: (URL(string:finalUrl)!))
        webKit.load(request)
    }
    
    @IBAction func telButton(sender: Any) {
        UIApplication.shared.open(URL(string: "tel://\(tel)")!, options: [:], completionHandler: nil)
    }
    @IBAction func backButton(sender:UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    func changeType(){
        
        finalUrl.append(url[indexNumber])
        finalTel.append(tel[indexNumber])
        finalName.append(name[indexNumber])
        finalImage.append(imageURLString[indexNumber])
        
        if finalImage != "" && finalName != "" && finalTel != "" && finalUrl != "" {
            
            for i in 0...imageURLString.count/tel.count/name.count/url.count {
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
