//
//  AnalyticsModel.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import Foundation
import SwiftyJSON
import Firebase
import Alamofire

protocol DoneCatchProtocol {
    func catchProtocol(arrayData:Array<ShopData>, resultCount:Int)
}

class AnalyticsModel{
    
    var idoValue:Double?
    var keidoValue:Double?
    var urlString:String?
    var doneCatchDataProtocol:DoneCatchProtocol?
    var shopDataArray = [ShopData]()
    
    var failedToGetInfo = ""
    
    init(latitude: Double, longitude: Double, url:String){
        idoValue = latitude
        keidoValue = longitude
        urlString = url
    }
    
    // analyize with JSON
    func analyizeWithJSON(){
        let encoderUrlString:String = urlString!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        AF.request(encoderUrlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { [self] (response) in
            
            print(response.debugDescription)
            
            switch response.result {
            case .success:
                do{
                    let json:JSON = try JSON(data: response.data!)
                    print(json.description)
                    var totalCount = json["total_hit_count"].int
                    if totalCount == nil {
                        print("apiは０ですがアラートが出ていない可能性があります.")
                        return
                    } else if totalCount != nil {
                        if totalCount! > 15{
                            totalCount = 15
                        }
                    }
                    
                    for i in 0...totalCount! - 1{
                        //if info exit on JSON
                        if json["rest"][i]["latitude"] != "" && json["rest"][i]["longitude"] != "" && json["rest"][i]["url"] != "" && json["rest"][i]["name"] != "" && json["rest"][i]["tel"] != "" && json["rest"][i]["image_url"]["shop_image1"] != "" {
                            
                            //start analyzing....
                            let shopData = ShopData(latitude: json["rest"][i]["latitude"].string, longitude: json["rest"][i]["longitude"].string, url: json["rest"][i]["url"].string, name: json["rest"][i]["name"].string, tel: json["rest"][i]["tel"].string, shop_image: json["rest"][i]["image_url"]["shop_image1"].string)
                            
                            self.shopDataArray.append(shopData)
                        }else{
                            print("error has occured")
                            
                        }
                    }
                    self.doneCatchDataProtocol?.catchProtocol(arrayData: self.shopDataArray, resultCount: self.shopDataArray.count)
                }catch{
                    print("error just happened")
                }
                break
            case .failure:
                break
            }
        }
        
    }
    func alert(){
        let alert:UIAlertController = UIAlertController(title: "警告", message: "情報を取得できませんでした。", preferredStyle: .alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
            print("OK")
        })
        alert.addAction(okAction)
    }
    
}
