//
//  SaveDataOnTheList.swift
//  BestMeal
//
//  Created by Owner on 2021/01/06.
//

import Foundation
import Firebase
import PKHUD

class SaveListData {
    
    var shopImage:String! = ""
    var shopName:String! = ""
    var shopInfoUrl:String! = ""
    var ref:DatabaseReference!
    
    init(shopImage:String, shopName:String, shopInfoUrl:String){
        
        self.shopName = shopName
        self.shopImage = shopImage
        self.shopInfoUrl = shopInfoUrl
        
        ref = Database.database().reference().child("users").child("userID").childByAutoId()
    }
    
    init(snapShot:DataSnapshot){
        ref = snapShot.ref
        
        if let value = snapShot.value as? [String:Any]{
            shopName = value["shopName"] as? String
            shopImage = value["shopImage"] as? String
            shopInfoUrl = value["shopInfoUrl"] as? String
        }
    }
    
    func toContents() -> [String:Any]{
        return ["shopName":shopName!, "shopImage":shopImage!, "shopInfoUrl":shopInfoUrl!]
    }
    func save(){
        ref.setValue(toContents())
    }
}
