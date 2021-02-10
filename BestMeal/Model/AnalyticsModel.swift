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

    class AnalyticsModel {
        
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
        
        // analyize with JSON
        func analyizeWithJSON() {
            let encoderUrlString: String = urlString!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            AF.request(encoderUrlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { [self] (response) in
                print(response.debugDescription)
                
                switch response.result {
                case .success:
                    do {
                        let json: JSON = try JSON(data: response.data!)
                        print(json.description)
                        var totalCount = json["total_hit_count"].int
                        
                        if totalCount != nil {
                            if totalCount! > 15{
                                totalCount = 15
                            }
                            
                            for each in 0...totalCount! - 1 {
                                //if info exit on JSON
                                if json["rest"][each]["latitude"] != "" && json["rest"][each]["longitude"] != "" && json["rest"][each]["url"] != "" && json["rest"][each]["name"] != "" && json["rest"][each]["tel"] != "" && json["rest"][each]["image_url"]["shop_image1"] != "" {
                                    
                                    // start analyzing....
                                    let shopData = ShopData(latitude: json["rest"][each]["latitude"].string!, longitude: json["rest"][each]["longitude"].string!, url: json["rest"][each]["url"].string!, name: json["rest"][each]["name"].string!, tel: json["rest"][each]["tel"].string!, shopImage: json["rest"][each]["image_url"]["shop_image1"].string!)
                                    
                                    self.shopDataArray.append(shopData)
                                } else {
                                    print("error has occured")
                                }
                            }
                        } else {
                            if totalCount == nil {
                                // mainAlert()
                            }
                        }
                        self.doneCatchDataProtocol?.catchProtocol(arrayData: self.shopDataArray, resultCount: self.shopDataArray.count)
                    } catch {
                        print("error just happened")
                    }
                    // break
                case .failure:
                    print("エラー検出された。")
                    // break
                }
            }
        }
    }
