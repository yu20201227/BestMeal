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
import RxSwift
import RxCocoa

enum buttonActionOnCardSwipeView {
    case backButton
    case toFavListButton
}

class CardSwipeViewController: BaseViewController, VerticalCardSwiperDelegate {
    
    var userPass = String()
    var placeDataModelArray = [PlaceDataModel]()
    let disposeBag = DisposeBag()
    var buttonProtocol: buttonActionOnCardSwipeViewProtocol?
    
    @IBOutlet weak var cardSwiper: VerticalCardSwiper! {
        didSet {
            cardSwiper.delegate = self
            cardSwiper.datasource = self
            cardSwiper.register(nib: UINib(nibName: Nib.cardViewCell,
                                           bundle: nil),forCellWithReuseIdentifier: CellIdentifier.cardViewCell)
        }
    }
    
    @IBOutlet weak var backImageView: UIImageView! {
        didSet {
            backImageView.image = R.image.food()
            backImageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var goBackButton: UIButton! {
        didSet {
            self.goBackButton.setImage(R.image.goBackButtonImage(), for: .normal)
        }
    }
    
    @IBOutlet weak var goListButton: UIButton! {
        didSet {
            self.goListButton.setImage(R.image.listButtonImage(), for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        setup()
    }
    
    override func setup() {
        goListButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.buttonAction(buttonAction: .toFavListButton)
        })
        .disposed(by: disposeBag)
        
        goBackButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.buttonAction(buttonAction: .backButton)
        })
        .disposed(by: disposeBag)

    }
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return FetchAllDatas.urlInfos.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let listVC = segue.destination as? FavoritePlaceListViewController {
            listVC.listImage = ArrayData.likePlaceImageUrlArrary
            listVC.listTel = ArrayData.likePlaceTelArray
            listVC.listName = ArrayData.likePlaceNameArray
            listVC.listUrl = ArrayData.likePlaceUrlArray
        }
    }
}

extension CardSwipeViewController: VerticalCardSwiperDatasource {
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.cardViewCell, for: index) as? CardViewCell {
            view.backgroundColor = verticalCardSwiperView.backgroundColor
            _ = FetchAllDatas.imageUrlStringInfos[index]
            _ = FetchAllDatas.urlInfos[index]
            let placename = FetchAllDatas.nameInfos[index]
            cardCell.setRandomBackgroundColor()
            cardCell.placeNameLabel.text = placename
            cardCell.goodImages.sd_setImage(with:URL(string:FetchAllDatas.imageUrlStringInfos[index]), completed: nil)
            return cardCell
        }
        return CardCell()
    }
    
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        let indexNumber = index
                
// //        以下、右スワイプ後の冗長な処理と変更できるかも
//                func insertDatas() {
//                    let finalDatas = [ ArrayData(likePlaceUrlArray: FetchAllDatas.urlInfos[indexNumber],
//                                                 likePlaceNameArray: FetchAllDatas.telInfos[indexNumber],
//                                                 likePlaceImageUrlArrary: FetchAllDatas.nameInfos[indexNumber],
//                                                 likePlaceTelArray: FetchAllDatas.imageUrlStringInfos[indexNumber])
//                    ]
//                }
        
        if swipeDirection == .Right {
                    
            ArrayData.likePlaceUrlArray.append(FetchAllDatas.urlInfos[indexNumber])
            ArrayData.likePlaceTelArray.append(FetchAllDatas.telInfos[indexNumber])
            ArrayData.likePlaceNameArray.append(FetchAllDatas.nameInfos[indexNumber])
            ArrayData.likePlaceImageUrlArrary.append(FetchAllDatas.imageUrlStringInfos[indexNumber])
            
            if ArrayData.likePlaceUrlArray.count == Numbers.smallestNumber { return }
            else { let addDataToFirebase = PlaceDataModel(placeName: FetchAllDatas.nameInfos[indexNumber], placeImage: FetchAllDatas.imageUrlStringInfos[indexNumber], placeUrl: FetchAllDatas.urlInfos[indexNumber], userPass: userPass)
                addDataToFirebase.save()
            }
        }
        
        FetchAllDatas.urlInfos.remove(at: index)
        FetchAllDatas.telInfos.remove(at: index)
        FetchAllDatas.nameInfos.remove(at: index)
        FetchAllDatas.imageUrlStringInfos.remove(at: index)
    }
    
    // 全てのカードスワイプ完了時にリストへ飛ばす確認ダイアログ
    func didSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
                        
        if FetchAllDatas.urlInfos.count == Numbers.smallestNumber {
            let alertDialog: UIAlertController = UIAlertController(title: AlertTitle.jumpToList, message: AlertMessage.lastSwipableCard, preferredStyle: .alert)
            let okAction: UIAlertAction = UIAlertAction(title: AlertTitle.okMessage, style: .default, handler: {
                (_: UIAlertAction!) -> Void in
                print(AlertTitle.okMessage)
                self.performSegue(withIdentifier: SegueIdentifier.toList, sender: nil)
            })
            alertDialog.addAction(okAction)
            present(alertDialog, animated: true, completion: nil)
        }
    }
    
    func buttonAction(buttonAction: buttonActionOnCardSwipeView) {
        switch buttonAction {
        case .backButton:
            cancelButton()
        case .toFavListButton:
            userButtonActions()
        }
        
    }
    func userButtonActions() {
        performSegue(withIdentifier: SegueIdentifier.toList, sender: nil)
    }
    func cancelButton() {
        dismiss(animated: true, completion: nil)
    }

}
