//
//  ShopData.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import Foundation
import SDWebImage

struct ShopData {
    let latitude: String
    let longitude: String
    let url: String
    let name: String
    let tel: String
    let shopImage: String
}

struct FetchAllDatas {
    static var urlInfos = [String]()
    static var nameInfos = [String]()
    static var imageUrlStringInfos = [String]()
    static var telInfos = [String]()
}

struct ArrayData {
    static var likePlaceUrlArray = [String]()
    static var likePlaceNameArray = [String]()
    static var likePlaceImageUrlArrary = [String]()
    static var likePlaceTelArray = [String]()
}
