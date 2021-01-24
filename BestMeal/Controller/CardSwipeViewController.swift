//
//  CardSwipeViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//品質管理：a版

import UIKit
import VerticalCardSwiper
import Lottie
import Firebase
import SDWebImage
import ChameleonFramework
import FirebaseFirestore
import FirebaseDatabase


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
    
    var dataSets = [PlaceDataModel]()
    let db = Firestore.firestore()
    var indexNumber = Int()
    var infoCount = 1
    
    @IBOutlet weak var cardSwiper:VerticalCardSwiper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardSwiper.delegate = self
        cardSwiper.datasource = self
        cardSwiper.register(nib:UINib(nibName: "CardViewCell", bundle: nil), forCellWithReuseIdentifier: "CardViewCell")
        cardSwiper.reloadData()
    }
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return urlInfos.count
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
    
    func didSwipeCardAway(card:CardCell, index: Int, swipeDirection: SwipeDirection) {
        indexNumber = index
        
        if swipeDirection == .Right {
            likePlaceUrlArray.append(urlInfos[indexNumber])
            likePlaceTelArray.append(telInfos[indexNumber])
            likePlaceNameArray.append(nameInfos[indexNumber])
            likePlaceImageUrlAray.append(imageUrlStringInfos[indexNumber])
        }
        if nameInfos.count == 0 {
            if swipeDirection == .Right {
                performSegue(withIdentifier: "toList", sender: nil)
            } else {
                if nameInfos.count == 0{
                    if swipeDirection == .Left {
                        performSegue(withIdentifier: "toList", sender: nil) }
                }
            }
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
        listVC.listImage = self.likePlaceImageUrlAray
        listVC.listTel = self.likePlaceTelArray
        listVC.listName = self.likePlaceNameArray
        listVC.listUrl = self.likePlaceUrlArray
    }
    
    func didDragCard(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        // Called when the user starts dragging a card to the side (optional).
            if urlInfos.count <= infoCount {
                if swipeDirection == .Right {
                let listView = FavoritePlaceListViewController()
                var listViewUrl = listView.listUrl
                listViewUrl = urlInfos
                performSegue(withIdentifier: "toList", sender: nil)
            }
        }
    }
}


