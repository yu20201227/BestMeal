//
//  FavoritePlaceListViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import UIKit
import SDWebImage
import MapKit
import RxSwift
import RxCocoa

var placeDatas = [String]()

// お気に入りリスト画面
class FavoritePlaceListViewController: BaseViewController, UINavigationControllerDelegate {

    var placeDataModelArray = [PlaceDataModel]()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var favTableView: UITableView! {
        didSet {
            favTableView.delegate = self
            favTableView.dataSource = self
        }
    }
    
        var listVC = displayDatas(listName: ArrayData.likePlaceNameArray, listUrl: ArrayData.likePlaceUrlArray, listImage: ArrayData.likePlaceImageUrlArrary, listTel: ArrayData.likePlaceTelArray)
        
    
    
    @IBOutlet weak var didTapGoBackButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        overrideUserInterfaceStyle = .light
        setup()
    }
    
    override func setup() {
        didTapGoBackButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.didTapGoBackButtonMethod()
        })
        .disposed(by: disposeBag)
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return Numbers.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Numbers.heightForRowAt)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView,canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            listVC.listImage.remove(at: indexPath.row)
            listVC.listName.remove(at: indexPath.row)
            listVC.listTel.remove(at: indexPath.row)
            listVC.listUrl.remove(at: indexPath.row)
            favTableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func toDetailScreen() {
        performSegue(withIdentifier: SegueIdentifier.toDetail, sender: nil)
    }
}

extension FavoritePlaceListViewController: UITableViewDataSource {
    
    // MARK: - TODO - プロパティ４つをメンバワイズか何かでまとめられないか。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.cell, for: indexPath)
        cell.backgroundColor = .brown
                
        let indexName = listVC.listName[indexPath.row]
        let indexImage = listVC.listImage[indexPath.row]
        let indexUrl = listVC.listUrl[indexPath.row]
        let indexTel = listVC.listTel [indexPath.row]
        
        UserDefaults.standard.set(placeDatas, forKey: UserDefaultForKey.placeDatas)
        
        if let placeImageViewOnTheList = cell.contentView.viewWithTag(1) as? UIImageView {
                placeImageViewOnTheList.sd_setImage(with: URL(string: indexImage),
                                                    placeholderImage: R.image.noImage(),
                                                    options: .continueInBackground,
                                                    progress: nil, completed: nil)
                placeImageViewOnTheList.layer.cornerRadius = 30.0

            }
        
        if let placeNameLabelOnTheList = cell.contentView.viewWithTag(2) as? UILabel {
            placeNameLabelOnTheList.text = indexName
            placeNameLabelOnTheList.UILabelExtension(placeNameLabelOnTheList: placeNameLabelOnTheList)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listVC.listName.isEmpty { return Numbers.smallestNumber } else {
            return listVC.listName.count
        }
    }

}

extension FavoritePlaceListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UIApplication.shared.canOpenURL(URL(string: listVC.listUrl[indexPath.row])!){
            UIApplication.shared.open(URL(string: listVC.listUrl[indexPath.row])!)
        }
    }
}

// MARK: -Observableで実行するメソッドをエクステンション下に実装
extension FavoritePlaceListViewController {
    
    func didTapGoBackButtonMethod() {
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
