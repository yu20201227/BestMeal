//
//  CardSwipeViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.

import UIKit
import VerticalCardSwiper
import Lottie
import Firebase
import SDWebImage
import ChameleonFramework
import FirebaseDatabase

class CardSwipeViewController: UIViewController, VerticalCardSwiperDelegate, VerticalCardSwiperDatasource {
    
    var urlInfos = [String]()
    var nameInfos = [String]()
    var imageUrlStringInfos = [String]()
    var telInfos = [String]()
    var userPass = String()
    var likePlaceUrlArray = [String]()
    var likePlaceNameArray = [String]()
    var likePlaceImageUrlAray = [String]()
    var likePlaceTelArray = [String]()
    let dbRf = Database.database().reference()
    var indexNumber = Int()
    var infoCount = 1
    var saveProfileHere = [SaveProfile]()
    var placeDataModelArray = [PlaceDataModel]()
    
    @IBOutlet weak var cardSwiper: VerticalCardSwiper!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var goListButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let goBackImage = UIImage(named: "iconfinder_Arrow_doodle_11_3847915")
        self.goBackButton.setImage(goBackImage, for: .normal)
        let goListButton = UIImage(named: "list-2389219_1280-1")
        self.goListButton.setImage(goListButton, for: .normal)
        backImageView.image = UIImage(named: "Food")
        backImageView.contentMode = .scaleAspectFill
        
        self.navigationController?.isNavigationBarHidden = true
        if UserDefaults.standard.object(forKey: "userPass") != nil {
            userPass = (UserDefaults.standard.object(forKey: "userPass") as? String)!
        }
        cardSwiper.delegate = self
        cardSwiper.datasource = self
        cardSwiper.register(nib: UINib(nibName: "CardViewCell", bundle: nil), forCellWithReuseIdentifier: "CardViewCell")
        cardSwiper.reloadData()
    }
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return urlInfos.count
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "CardViewCell", for: index) as? CardViewCell {
            //verticalCardSwiperView.backgroundColor = UIColor.randomFlat()
            view.backgroundColor = verticalCardSwiperView.backgroundColor
             _ = imageUrlStringInfos[index]
             _ = urlInfos[index]
            let placename = nameInfos[index]
            cardCell.setRandomBackgroundColor()
            cardCell.placeNameLabel.text = placename
            cardCell.goodImages.sd_setImage(with: URL(string: imageUrlStringInfos[index]), completed: nil)
            return cardCell
        }
        return CardCell()
    }
    
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        indexNumber = index
        if swipeDirection == .Right {
            likePlaceUrlArray.append(urlInfos[indexNumber])
            likePlaceTelArray.append(telInfos[indexNumber])
            likePlaceNameArray.append(nameInfos[indexNumber])
            likePlaceImageUrlAray.append(imageUrlStringInfos[indexNumber])
            if likePlaceUrlArray.count != 0 && likePlaceImageUrlAray.count != 0 {
                let addDataToFirebase = PlaceDataModel(placeName: nameInfos[indexNumber], placeImage: imageUrlStringInfos[indexNumber], placeUrl: urlInfos[indexNumber], userPass: userPass)
                addDataToFirebase.save()
            }
        }
        urlInfos.remove(at: index)
        telInfos.remove(at: index)
        nameInfos.remove(at: index)
        imageUrlStringInfos.remove(at: index)
        if nameInfos.count == 0 {
            if swipeDirection == .Right {
                performSegue(withIdentifier: "toList", sender: nil)
            } else {
                if nameInfos.count == 0 {
                    if swipeDirection == .Left {
                        performSegue(withIdentifier: "toList", sender: nil) }
                }
            }
        }
    }
    
    @IBAction func backButton(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toFavListButton(sender: UIButton) {
        _ = FavoritePlaceListViewController()
        performSegue(withIdentifier: "toList", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listVC = segue.destination as! FavoritePlaceListViewController
        listVC.listImage = self.likePlaceImageUrlAray
        listVC.listTel = self.likePlaceTelArray
        listVC.listName = self.likePlaceNameArray
        listVC.listUrl = self.likePlaceUrlArray
    }
}
