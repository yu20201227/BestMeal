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
    
    var userPass = String()
    let dbRf = Database.database().reference()
    var indexNumber = Int()
    var saveProfileHere = [SaveProfile]()
    var placeDataModelArray = [PlaceDataModel]()
    
    @IBOutlet weak var cardSwiper: VerticalCardSwiper! {
        didSet {
            cardSwiper.delegate = self
            cardSwiper.datasource = self
            cardSwiper.register(nib: UINib(nibName: Nib.cardViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.cardViewCell)
        }
    }
    
    @IBOutlet weak var backImageView: UIImageView! {
        didSet {
            backImageView.image = UIImage(named: ImageName.food)
            backImageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var goListButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let goBackImage = UIImage(named: ImageName.goBackButtonImage)
        self.goBackButton.setImage(goBackImage, for: .normal)
        let goListButton = UIImage(named: ImageName.goListButtonImage)
        self.goListButton.setImage(goListButton, for: .normal)
        
        if UserDefaults.standard.object(forKey: UserDefaultForKey.userPass) != nil {
            userPass = (UserDefaults.standard.object(forKey: UserDefaultForKey.userPass) as? String)!
        }
        cardSwiper.reloadData()
        
        //        if UserDefaults.standard.object(forKey: UserDefaultForKey.placeDatas) != nil {
        //            placeDatas = UserDefaults.standard.object(forKey:UserDefaultForKey.placeDatas) as! [String]
        //        }
    }
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return FetchAllDatas.urlInfos.count
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.cardViewCell, for: index) as? CardViewCell {
            //verticalCardSwiperView.backgroundColor = UIColor.randomFlat()
            view.backgroundColor = verticalCardSwiperView.backgroundColor
            _ = FetchAllDatas.imageUrlStringInfos[index]
            _ = FetchAllDatas.urlInfos[index]
            let placename = FetchAllDatas.nameInfos[index]
            cardCell.setRandomBackgroundColor()
            cardCell.placeNameLabel.text = placename
            cardCell.goodImages.sd_setImage(with: URL(string:FetchAllDatas.imageUrlStringInfos[index]), completed: nil)
            return cardCell
        }
        return CardCell()
    }
    
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        indexNumber = index
        if swipeDirection == .Right {
            ArrayData.likePlaceUrlArray.append(FetchAllDatas.urlInfos[indexNumber])
            ArrayData.likePlaceTelArray.append(FetchAllDatas.telInfos[indexNumber])
            ArrayData.likePlaceNameArray.append(FetchAllDatas.nameInfos[indexNumber])
            ArrayData.likePlaceImageUrlArrary.append(FetchAllDatas.imageUrlStringInfos[indexNumber])
            if ArrayData.likePlaceUrlArray.count != Numbers.smallestNumber {
                let addDataToFirebase = PlaceDataModel(placeName: FetchAllDatas.nameInfos[indexNumber], placeImage: FetchAllDatas.imageUrlStringInfos[indexNumber], placeUrl: FetchAllDatas.urlInfos[indexNumber], userPass: userPass)
                addDataToFirebase.save()
            }
        }
        
        FetchAllDatas.urlInfos.remove(at: index)
        FetchAllDatas.telInfos.remove(at: index)
        FetchAllDatas.nameInfos.remove(at: index)
        FetchAllDatas.imageUrlStringInfos.remove(at: index)
        
        if FetchAllDatas.nameInfos.count == Numbers.smallestNumber {
            if swipeDirection == .Right {
                performSegue(withIdentifier: SegueIdentifier.toList, sender: nil)
//            } else if swipeDirection == .left {
//                performSegue(withIdentifier: SegueIdentifier.toList, sender: nil)
//            }
        }
    }
    }
    
    @IBAction func backButton(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toFavListButton(sender: UIButton) {
        if UserDefaults.standard.object(forKey: UserDefaultForKey.placeDatas) != nil {
            //            placeDatas = UserDefaults.standard.object(forKey:  UserDefaultForKey.placeDatas) as! [String]
            //        }
            _ = FavoritePlaceListViewController()
            performSegue(withIdentifier: SegueIdentifier.toList, sender: nil)
        }
    }
    
    // if let使用
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let listVC = segue.destination as? FavoritePlaceListViewController {
            listVC.listImage = ArrayData.likePlaceImageUrlArrary
            listVC.listTel = ArrayData.likePlaceTelArray
            listVC.listName = ArrayData.likePlaceNameArray
            listVC.listUrl = ArrayData.likePlaceUrlArray
        }
    }
}
