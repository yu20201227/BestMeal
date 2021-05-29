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
    static let jumpToList = "リストを見に行きますか？"
}

struct AlertMessage {
    static let seekOneMoreTime =  "もう一度やり直してください"
    static let notEnoughPass =  "パスワードは6文字以上にしてください"
    static let alertChangeKeyword =  "違うキーワードで検索してください！"
    static let keywordIsEmpty =  "キーワードを入れてください！"
    static let lastSwipableCard = "スワイプが終了しました。"
}

struct ForSourceType {
    static let openingAnimation =  "10685-breakfast"
    static let registerPermitAnimation = "9637-check"
}

struct FileType {
    static let jsonType =  "json"
}

struct ApiKey {
    static let apiKey = "8156492e74d084a1bba1d7fdd1b39906"
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
    static let toDetail = "toDetail"
}

struct NamedVC {
     static var listVC: FavoritePlaceListViewController!
}

struct SegueName {
    static var favoritePlaceListViewController = "FavoritePlaceListViewController"
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
    static let maxInfoCount = 15
    static let registerAnimationSpeed = 1.0
    static let listLabelCornerRadius = 10.0
    static let listImageCornerRadius = 30.0
}

struct StoreDataType {
    static let email = "EMAIL"
    static let pass = "PASS"
}
