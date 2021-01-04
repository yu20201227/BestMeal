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

    var userPass:String! = ""
    var userEmail:String! = ""
    var ref:DatabaseReference! = Database.database().reference().child("profile")

    init(snapShot:DataSnapshot){
        ref = snapShot.ref
        if let value = snapShot.value as? [String:Any]{
            userEmail = value["userEmail"] as? String
            userPass = value["userPass"] as? String

        }
        func toContents()-> [String:Any]{
            return ["userEmail":userEmail, "userPass":userPass]

        }
        //MusicListAppでは"userName"は"autoID"になっている
        func saveProfile(){
            ref.setValue(toContents())
            UserDefaults.standard.set(ref.key, forKey: "userName")
        }
    }
}
