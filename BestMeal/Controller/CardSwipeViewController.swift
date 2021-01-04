//
//  CardSwipeViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//品質管理：a版

import UIKit
import VerticalCardSwiper
import DTGradientButton
import Lottie
import Firebase
import SDWebImage
import ChameleonFramework

class CardSwipeViewController: UIViewController, VerticalCardSwiperDelegate, VerticalCardSwiperDatasource{
    
    var urlInfos = [String]()
    var nameInfos = [String]()
    var imageUrlStringInfos = [String]()
    var telInfos = [String]()
    
    var userPass = String()
    var userEmail = String()
    
    var likePlaceUrlArray = [String]()
    var likePlaceNameArray = [String]()
    var likePlaceImageUrlAray = [String]()
    var likePlaceTelArray = [String]()
    
    var indexNumber = Int()
    
    @IBOutlet weak var cardSwiper:VerticalCardSwiper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardSwiper.delegate = self
        cardSwiper.datasource = self
        cardSwiper.register(nib:UINib(nibName: "CardViewCell", bundle: nil), forCellWithReuseIdentifier: "CardViewCell")
        cardSwiper.reloadData()
        
        
        
        
    }
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return nameInfos.count
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        

        
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "CardViewCell", for: index) as? CardViewCell {
            verticalCardSwiperView.backgroundColor = UIColor.randomFlat()
            view.backgroundColor = verticalCardSwiperView.backgroundColor
            
            //カードに配列を表示させる
            let placeImage = imageUrlStringInfos[index]
            let placename = nameInfos[index]
            let placeUrl = urlInfos[index]
            cardCell.setRandomBackgroundColor()
            cardCell.placeNameLabel.text = placename
            cardCell.placeNameLabel.textColor = UIColor.black
            cardCell.placeUrlInfoLabel.text = placeUrl
            cardCell.goodImages.sd_setImage(with: URL(string: imageUrlStringInfos[index]), completed: nil)
            
            return cardCell
            
        }
        return CardCell()
    }

    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        urlInfos.remove(at: index)
        telInfos.remove(at: index)
        nameInfos.remove(at: index)
        imageUrlStringInfos.remove(at: index)
    }
    
    func didSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        
        //[]内をindexNumberからindexへ変更
        if swipeDirection == .Right {
            //カードが0枚になってしまった瞬間にリストへ遷移したい(下記のコードではダメだった）
            if urlInfos.count == 0 {
                performSegue(withIdentifier: "toList", sender: nil)
            }
            likePlaceUrlArray.append(urlInfos[index])
            likePlaceTelArray.append(telInfos[index])
            likePlaceNameArray.append(nameInfos[index])
            likePlaceImageUrlAray.append(imageUrlStringInfos[index])
            
//            if likePlaceNameArray.count != 0 && likePlaceTelArray.count != 0 && likePlaceUrlArray.count != 0 && likePlaceImageUrlAray.count != 0 {
//
//                let dataOnTheCardModel = DataOnTheCardModel(nameOnTheCard: nameInfos[indexNumber], imageOnTheCard: imageUrlStringInfos[indexNumber], userPass: userPass, userEmail: userEmail, telOnTheCard: telInfos[indexNumber], urlInfoOnTheCard: urlInfos[indexNumber])
//
//                    dataOnTheCardModel.save()
                //performSegue(withIdentifier: "toList", sender: nil)
//
//                }
        }
    }
    
    
    @IBAction func backButton(sender:UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func toFavListButton(sender:UIButton){
        performSegue(withIdentifier: "toList", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listVC = segue.destination as! FavoritePlaceListViewController
        //ここには右にスワイプした数がしっかりと遷移されているため次のViewControllerだと思われる
        listVC.listImage = self.likePlaceImageUrlAray
        listVC.listTel = self.likePlaceTelArray
        listVC.listName = self.likePlaceNameArray
        listVC.listUrl = self.likePlaceUrlArray
    }
    
}


//カード画面の最後に戻るボタンを入れて、カードがなくなったときに押してリストに飛んでもらう

