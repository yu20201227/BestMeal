//
//  GetUserInfoToMakeOriginalList.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import Foundation
import Firebase
import PKHUD

class GetUserInfoToMakeOriginalList {
    
    var userEmail:String! = ""
    var userName:String! = ""
    var ref:DatabaseReference! = Database.database().reference().child("profile")
    
    init(snapShot:DataSnapshot){
        ref = snapShot.ref
        if let value = snapShot.value as? [String:Any]{
            userName = value["userName"] as? String
            userEmail = value["userEmail"] as? String
            
        }
    }
}
