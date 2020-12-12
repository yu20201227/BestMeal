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
    var userEmail:String! = ""
    var userName:String! = ""
    var ref:DatabaseReference!
    
    init(nameOnTheCard:String, imageOnTheCard:String, userEmail:String, userName:String, telOnTheCard:String, urlInfoOnTheCard:String){
        
        self.nameOnTheCard = nameOnTheCard
        self.imageOnTheCard = imageOnTheCard
        self.userName = userName
        self.userEmail = userEmail
        self.telOnTheCard = telOnTheCard
        self.urlInfoOnTheCard = urlInfoOnTheCard
        
        ref = Database.database().reference().child("users").child(userName).childByAutoId()
    }
    
    init(snapShot:DataSnapshot){
        ref = snapShot.ref
        if let value = snapShot.value as? [String:Any]{
            
            nameOnTheCard = value["nameOnTheCard"] as? String
            imageOnTheCard = value["imageOnTheCard"] as? String
            userName = value["userName"] as? String
            userEmail = value["userEmail"] as? String
            telOnTheCard = value["telOnTheCard"] as? String
            urlInfoOnTheCard = value["urlInfoOnTheCard"] as? String

            
        }
    }
    
    func toContents()->[String:Any]{
        return ["nameOnTheCard":nameOnTheCard!, "imageOnTheCard":imageOnTheCard!, "userEmail":userEmail!, "userName":userName!, "telOnTheCard":telOnTheCard, "urlInfoOnTheCard":urlInfoOnTheCard]
    }
    func save(){
        ref.setValue(toContents())
    }

}
