//
//  DataOnTheCardModel.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import Foundation
import Firebase
import PKHUD

class DataOnTheCardModel {
    
    var nameOnTheCard:String! = ""
    var imageOnTheCard:String! = ""
    var telOnTheCard:String! = ""
    var urlInfoOnTheCard:String! = ""
    var userPass:String! = ""
    var userEmail:String! = ""
    var ref:DatabaseReference!
    
    init(nameOnTheCard:String, imageOnTheCard:String, userPass:String, userEmail:String, telOnTheCard:String, urlInfoOnTheCard:String){
        
        self.nameOnTheCard = nameOnTheCard
        self.imageOnTheCard = imageOnTheCard
        self.userEmail = userEmail
        self.userPass = userPass
        self.telOnTheCard = telOnTheCard
        self.urlInfoOnTheCard = urlInfoOnTheCard
        
        ref = Database.database().reference().child("users").child(userEmail).childByAutoId()
    }
    
    init(snapShot:DataSnapshot){
        ref = snapShot.ref
        if let value = snapShot.value as? [String:Any]{
            
            nameOnTheCard = value["nameOnTheCard"] as? String
            imageOnTheCard = value["imageOnTheCard"] as? String
            userEmail = value["userEmail"] as? String
            userPass = value["userPass"] as? String
            telOnTheCard = value["telOnTheCard"] as? String
            urlInfoOnTheCard = value["urlInfoOnTheCard"] as? String

            
        }
    }
    
    func toContents()->[String:Any]{
        return ["nameOnTheCard":nameOnTheCard!, "imageOnTheCard":imageOnTheCard!, "userPass":userPass!, "userEmail":userEmail!, "telOnTheCard":telOnTheCard!, "urlInfoOnTheCard":urlInfoOnTheCard!]
    }
    func save(){
        ref.setValue(toContents())
    }

}
