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
//ここ、要見直し（リストに保存するヒントになる）

class PlaceDataModel {
    
    var placeImage:String! = ""
    var placeName:String! = ""
    var placeUrl:String! = ""
    var ref:DatabaseReference!
    var docID:String! = ""
    var db = Firestore.firestore().collection("placeData")
    
    init(placeName:String, placeImage:String, placeUrl:String, docID:String){

        self.placeName = placeName
        self.placeImage = placeImage
        self.placeUrl = placeUrl
        self.docID = docID
        
    }

    init(snapShot:DataSnapshot){
        ref = snapShot.ref

        if let value = snapShot.value as? [String:Any]{
            placeImage = value["placeImage"] as? String
            placeName = value["placeName"] as? String
            placeUrl = value["placeUrl"] as? String
            docID = value["docID"] as? String
            
        }
    }

    func toContents(){
         self.db.document().setData(
            ["placeName":placeName as Any, "placeImage":placeImage as Any, "placeUrl":placeUrl as Any])
    }
    
    func save(){
        ref.setValue(toContents())
    }
}

