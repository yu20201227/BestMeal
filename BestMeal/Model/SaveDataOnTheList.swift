////
////  SaveDataOnTheList.swift
////  BestMeal
////
////  Created by Owner on 2021/01/06.
////

import Foundation
import Firebase
import Alamofire
import FirebaseDatabase

struct PlaceDataModel {
    
    var placeImage: String! = ""
    var placeName: String! = ""
    var placeUrl: String! = ""
    var ref: DatabaseReference!


    init(placeName: String, placeImage: String, placeUrl: String) {

        self.placeName = placeName
        self.placeImage = placeImage
        self.placeUrl = placeUrl
        
        ref = Database.database().reference().child("placeImage")
    }

    init(snapShot: DataSnapshot) {

        if let value = snapShot.value as? [String: Any] {
            placeImage = value["placeImage"] as? String
            placeName = value["placeName"] as? String
            placeUrl = value["placeUrl"] as? String
        }
    }

    func toContents() -> [String: Any] {
         return
            ["placeName": placeName! as Any, "placeImage": placeImage! as Any, "placeUrl": placeUrl! as Any]
    }

    func save() {
        ref.setValue(toContents())
    }
}
