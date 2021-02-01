//
//  SaveDataOnTheList.swift
//  BestMeal
//
//  Created by Owner on 2021/01/06.
//

import Foundation
import Firebase
import Alamofire
import FirebaseDatabase

class PlaceDataModel {
    
    var placeImage:String! = ""
    var placeName:String! = ""
    var placeUrl:String! = ""
    var ref:DatabaseReference!
    var userPass:String! = ""
    
    init(placeName:String, placeImage:String, placeUrl:String, userPass: String){

        self.placeName = placeName
        self.placeImage = placeImage
        self.placeUrl = placeUrl
        self.userPass = userPass
        
        ref = Database.database().reference().child("placeData").childByAutoId()
        
    }

    init(snapShot:DataSnapshot){
        ref = snapShot.ref

        if let value = snapShot.value as? [String:Any]{
            placeImage = value["placeImage"] as? String
            placeName = value["placeName"] as? String
            placeUrl = value["placeUrl"] as? String
            userPass = value["userPass"] as? String
            
        }
    }

    func toContents() -> [String:Any] {
         return
            ["placeName":placeName! as Any, "placeImage":placeImage! as Any, "placeUrl":placeUrl! as Any, "userPass":userPass as Any]
    }
    
    func save(){
        ref.setValue(toContents())
    }
}

