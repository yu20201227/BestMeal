//
//  ShopData.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import Foundation
import SDWebImage

struct ShopData {
    var latitude: String?
    var longitude: String?
    var url: String?
    var name: String?
    var tel: String?
    var shopImage: String?
    
    init(latitude: String, longitude: String, url: String, name: String, tel: String, shopImage: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.url = url
        self.name = name
        self.tel = tel
        self.shopImage = shopImage
    }
}
