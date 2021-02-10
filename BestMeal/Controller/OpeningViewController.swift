//
//  OpeningViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//
// provisioningfileメモ
// 実機でビルドするときは「development」を利用し、apppstoreへ申請の際は「distribution」を使用する。
import UIKit
import Lottie

class OpeningViewController: UIViewController {
    
    var userPass = String()
    
    @IBOutlet var didTapToNextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didTapToNextButton.backgroundColor = .white
        didTapToNextButton.layer.cornerRadius = 30.0
        startOpeningAnimation()
        if UserDefaults.standard.object(forKey: "userPass") != nil {
            userPass = (UserDefaults.standard.object(forKey: "userPass") as? String)!
        }
        view.backgroundColor = UIColor.flatMint()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func nextButton(sender: UIButton) {
        if UserDefaults.standard.object(forKey: "userPass") != nil {
            userPass = (UserDefaults.standard.object(forKey: "userPass") as? String)!
            performSegue(withIdentifier: "toSearch", sender: nil)
        } else {
            performSegue(withIdentifier: "toRegister", sender: nil)
        }
    }
}
