//
//  CardSwipeViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.

import UIKit
import VerticalCardSwiper
import SDWebImage
import ChameleonFramework
import RxSwift
import RxCocoa

enum ButtonActionOnCardSwipeView {
    case backButton
    case toFavListButton
}
// カードスワイプ店舗選択画面
final class CardSwipeViewController: BaseViewController, VerticalCardSwiperDelegate, CardSwiperModelProtocol {
    
    var presenter: CardSwipePresenter = CardSwipeViewPresenter()
    var placeDataModelArray = [PlaceDataModel]()
    let disposeBag = DisposeBag()
    
    @IBOutlet private weak var cardSwiper: VerticalCardSwiper!
    @IBOutlet private weak var backImageView: UIImageView!
    @IBOutlet private weak var goBackButton: UIButton!
    @IBOutlet private weak var goListButton: UIButton!
    
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
        
        cardSwiper.delegate = self
        cardSwiper.datasource = self
        cardSwiper.register(nib: UINib(nibName: Nib.cardViewCell,
                                       bundle: nil),forCellWithReuseIdentifier: CellIdentifier.cardViewCell)
        backImageView.image = R.image.food()
        backImageView.contentMode = .scaleAspectFill
        self.goBackButton.setImage(R.image.goBackButtonImage(), for: .normal)
        self.goListButton.setImage(R.image.listButtonImage(), for: .normal)
    }
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return FetchAllDatas.urlInfos.count
    }
    
    private func buttonAction(buttonAction: ButtonActionOnCardSwipeView) {
        switch buttonAction {
        case .backButton:
            didTapGoBackAction()
        case .toFavListButton:
            didTapGoNextAction()
        }
    }
    
    internal func didTapGoNextAction() {
        self.presenter.gotoListScreen(self)
    }
    
    internal func didTapGoBackAction() {
        self.presenter.goBackToPreviousScreen(self)
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
            
            if ArrayData.likePlaceUrlArray.count == Numbers.smallestNumber { print("データが空になっています"); return }
            else { let addDataToFirebase = PlaceDataModel(placeName: FetchAllDatas.nameInfos[indexNumber], placeImage: FetchAllDatas.imageUrlStringInfos[indexNumber], placeUrl: FetchAllDatas.urlInfos[indexNumber])
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
}
