//
//  GetDataFromFireStore.swift
//  BestMeal
//
//  Created by Owner on 2021/01/22.
//

import Foundation
import FirebaseFirestore
import Firebase

class LoadDBModel {
    
    var dataSets = [DataSet]()
    let db = Firestore.firestore()
    
    func loadContents(){
        db.collection("placeData").order(by: "placeName").addSnapshotListener { (snapShot, error) in
            if error != nil {
                return
            }
            
            if let snapShotDoc = snapShot?.documents {
                for doc in snapShotDoc {
                    let data = doc.data()
                    if let placeNames = data["placeName"] as? String, let placeImages = data["placeImage"] as? String, let placeUrls = data["placeUrl"] as? String {
                        
                        let newDataSet = DataSet(placeImage: placeImages, placeName: placeNames, placeUlr: placeUrls)
                        
                        self.dataSets.append(newDataSet)
                        self.dataSets.reverse()
                    }
                }
            }
        }
    }
}
