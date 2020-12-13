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
    
    var url = String()
    var name = String()
    var imageURLString = String()
    var tel = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTableView.sd_setImage(with: URL(string: imageURLString), completed: nil)
        let request = URLRequest(url: URL(string: url)!)
        webKit.load(request)

    }
    @IBAction func telButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: "tel://\(tel)")!, options: [:], completionHandler: nil)
    }
    

}
