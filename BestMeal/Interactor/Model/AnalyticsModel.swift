//
//  AnalyticsViewController.swift
//  BestMeal
//
//  Created by Owner on 2021/01/28.
//

import UIKit
import Foundation
import SwiftyJSON
import Firebase
import Alamofire

protocol DoneCatchProtocol {
    func catchProtocol(arrayData: Array<ShopData>, resultCount: Int)
}

open class AnalyticsModel {
    
    var idoValue: Double?
    var keidoValue: Double?
    var urlString: String?
    var doneCatchDataProtocol: DoneCatchProtocol?
    var shopDataArray = [ShopData]()
    
    init(latitude: Double, longitude: Double, url: String) {
        idoValue = latitude
        keidoValue = longitude
        urlString = url
    }
    
    
    func analyizeWithJSON() {
        
        // MARK: - closure
        let encoderUrlString: String = urlString!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        AF.request(encoderUrlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { [self] (response) in
            print(response.debugDescription)
            
            switch response.result {
            case .success:
                do {
                    let json = try JSON(data: response.data!)
                    print(json.description)
                    var totalCount = json["total_hit_count"].int
                    
                    // if totalCount != nil {
                    // Number.maxInfoCount == 15
                    if totalCount! > Numbers.maxInfoCount {
                        totalCount = Numbers.maxInfoCount
                        //  }
                        
                        for each in 0...totalCount! - 1 {

                            if json["rest"][each]["latitude"] != "" && json["rest"][each]["longitude"] != "" && json["rest"][each]["url"] != "" && json["rest"][each]["name"] != "" && json["rest"][each]["tel"] != "" && json["rest"][each]["image_url"]["shop_image1"] != "" {
                                
                                // start analyzing....
                                let shopData = ShopData(latitude: json["rest"][each]["latitude"].string!, longitude: json["rest"][each]["longitude"].string!, url:  json["rest"][each]["url"].string!, name: json["rest"][each]["name"].string!, tel: json["rest"][each]["tel"].string!, shopImage: json["rest"][each]["image_url"]["shop_image1"].string!)
                                
                                self.shopDataArray.append(shopData)
                            } else {
                                print("error has occured")
                            }
                        }
                    }
                    self.doneCatchDataProtocol?.catchProtocol(arrayData: self.shopDataArray, resultCount: self.shopDataArray.count)
                } catch {
                    print("error just happened")
                }
            case .failure:
                print("エラー検出された。")
            }
        }
    }
}
