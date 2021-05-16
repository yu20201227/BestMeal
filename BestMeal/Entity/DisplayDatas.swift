//
//  DisplayDatas.swift
//  BestMeal
//
//  Created by Owner on 2021/05/16.
//

import Foundation

struct displayDatas {
    
    var listName = [String]()
    var listUrl = [String]()
    var listImage = [String]()
    var listTel = [String]()
    
    init(listName: [String], listUrl: [String], listImage: [String], listTel: [String]) {
        self.listImage = listImage
        self.listUrl = listUrl
        self.listName = listName
        self.listTel = listTel
    }
}
