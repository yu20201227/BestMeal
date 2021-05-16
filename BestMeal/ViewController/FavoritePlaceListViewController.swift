//
//  FavoritePlaceListViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import UIKit
import SDWebImage
import Firebase
import MapKit
import RxSwift
import RxCocoa

var placeDatas = [String]()

class FavoritePlaceListViewController: BaseViewController, UITableViewDelegate, UINavigationControllerDelegate {
    
    var listName = [String]()
    var listUrl = [String]()
    var listImage = [String]()
    var listTel = [String]()
    
    var placeDataModelArray = [PlaceDataModel]()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var favTableView: UITableView! {
        didSet {
            favTableView.delegate = self
            favTableView.dataSource = self
        }
    }
    
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
            listUrl.remove(at: indexPath.row)
            listName.remove(at: indexPath.row)
            listImage.remove(at: indexPath.row)
            listTel.remove(at: indexPath.row)
            favTableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func toDetailScreen() {
        performSegue(withIdentifier: SegueIdentifier.toDetail, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UIApplication.shared.canOpenURL(URL(string: listUrl[indexPath.row])!){
            UIApplication.shared.open(URL(string: listUrl[indexPath.row])!)
        }
    }
}

extension FavoritePlaceListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.cell, for: indexPath)
        cell.backgroundColor = .brown
        
        let indexName = listName[indexPath.row]
        let indexImage = listImage[indexPath.row]
        let indexUrl = listUrl[indexPath.row]
        let indexTel = listTel[indexPath.row]
        
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
        if listName.isEmpty { return Numbers.smallestNumber } else {
            return listName.count
        }
    }

}

// MARK: -Observableで実行するメソッドをエクステンション下に実装
extension FavoritePlaceListViewController {
    
    func didTapGoBackButtonMethod() {
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
