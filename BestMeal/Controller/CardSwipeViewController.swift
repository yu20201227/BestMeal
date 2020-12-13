//
//  CardSwipeViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

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
    
    var userEmail = String()
    var userName = String()
    
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
            cardCell.setRandomBackgroundColor()
            cardCell.placeNameLabel.text = placename
            cardCell.placeNameLabel.textColor = UIColor.black
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
        indexNumber = index
        
        if swipeDirection == .Right {
            likePlaceUrlArray.append(urlInfos[indexNumber])
            likePlaceTelArray.append(telInfos[indexNumber])
            likePlaceNameArray.append(nameInfos[indexNumber])
            likePlaceImageUrlAray.append(imageUrlStringInfos[indexNumber])
            
            if likePlaceNameArray.count != 0 && likePlaceTelArray.count != 0 && likePlaceUrlArray.count != 0 && likePlaceImageUrlAray.count != 0 {
                
                let dataOnTheCardModel = DataOnTheCardModel(nameOnTheCard: nameInfos[indexNumber], imageOnTheCard: imageUrlStringInfos[indexNumber], userEmail: userEmail, userName: userName, telOnTheCard: telInfos[indexNumber], urlInfoOnTheCard: urlInfos[indexNumber])
                
                dataOnTheCardModel.save()
                
            }
        }
    }
    @IBAction func backButton(sender:UIButton){
        dismiss(animated: true, completion: nil)
    }
    @IBAction func toFavListButton(sender:UIButton){
        performSegue(withIdentifier: "toList", sender: nil)
    }
}
