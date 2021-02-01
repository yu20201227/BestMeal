//
//  UserData.swift
//  BestMeal
//
//  Created by Owner on 2021/01/29.
//

import Foundation
import Firebase
import FirebaseDatabase

class SaveProfile {
    
    var userEmail:String! = ""
    var userPass:String! = ""
    var ref:DatabaseReference!
    
    init(userEmail:String, userPass:String){
        self.userEmail = userEmail
        self.userPass = userPass
        
        //保存場所
        ref = Database.database().reference().child("profile").childByAutoId()
    }
    
    init(snapShot:DataSnapshot) {
        ref = snapShot.ref
        if let value = snapShot.value as? [String:Any] {
            userEmail = value["userEmail"] as? String
            userPass = value["userPass"] as? String
        }
    }
    func toContents() -> [String:Any] {
        return ["userEmail":userEmail! as Any, "userPass":userPass! as Any]
    }
    func saveProfile(){
        ref.setValue(toContents())
        UserDefaults.standard.set(userPass, forKey: "userPass")
    }
}
