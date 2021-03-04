//
//  Constraints.swift
//  BestMeal
//
//  Created by Owner on 2021/02/24.
//

import Foundation


struct ShopDataName {
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let url = "url"
    static let name = "name"
    static let tel = "tel"
    static let shopImage = "shopImage"
}

struct AlertTitle {
    static let notRegistered =  "登録できません🙇‍♂️"
    static let failedGetData =  "情報を取得できません🙇‍♂️"
    static let okMessage = "OK"
    static let failedToSearch =  "検索できません。"
}

struct AlertMessage {
    static let seekOneMoreTime =  "もう一度やり直してください"
    static let notEnoughPass =  "パスワードは6文字以上にしてください"
    static let alertChangeKeyword =  "違うキーワードで検索してください！"
    static let keywordIsEmpty =  "キーワードを入れてください！"
}

struct ForSourceType {
    static let openingAnimation =  "10685-breakfast"
    static let registerPermitAnimation = "9637-check"
}

struct FileType {
    static let jsonType =  "json"
}

struct ApiKey {
    static let apiKey = "d88dcf59b664fa3f9b089ed353977965"
}

struct UserDefaultForKey {
    static let userEmail = "userEmail"
    static let userPass = "userPass"
    static let placeDatas = "placeDatas"
}

struct SegueIdentifier {
    static let toSearch = "toSearch"
    static let toCards = "toCards"
    static let toList = "toList"
    static let gotoList = "gotoList"
    static let toDetail = "toDetail"
}

struct ImageName {
    static let registerBackImage = "backimage"
    static let searchBackImage = "search"
    static let searchTextBackImage = "zoom_saga"
    static let food = "Food"
    static let goBackButtonImage = "iconfinder_Arrow_doodle_11_3847915"
    static let goListButtonImage = "list-2389219_1280-1"
    static let noImage = "noImage"
}

struct LabelText {
    static let text = "zoom_saga"
}

struct Nib {
    static let cardViewCell = "CardViewCell"
}

struct CellIdentifier {
    static let cardViewCell = "CardViewCell"
    static let cell = "Cell"
}

struct ScreenText {
    static let registerLabel = "登録してはじめよう。"
    
}

struct Numbers {
    static let smallestNumber = 0
    static let numberOfSections = 1
    static let heightForRowAt = 160
    static let smallestPassNumber = 6
}
