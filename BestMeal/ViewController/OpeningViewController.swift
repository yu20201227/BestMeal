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

// MARK: -  シングルトンメモ（sharedインスタンス)
//class userInfo {
//    let shared = userInfo()
//    var userPass: String = ""
//}

class OpeningViewController: UIViewController {
    
    var userPass = String()
    
    @IBOutlet weak var didTapToNextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        startOpeningAnimation()
        view.backgroundColor = UIColor.flatMint()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
//        if UserDefaults.standard.object(forKey: "userPass") != nil {
//            userPass = (UserDefaults.standard.object(forKey: "userPass") as? String)!
        performSegue(withIdentifier: SegueIdentifier.toSearch, sender: nil)
//        } else {
//            performSegue(withIdentifier: "toRegister", sender: nil)
//        }
    }

    
    // MARK: - コード記述順テンプレート
    
}
// MARK: Protocols

protocol TestViewControllerDelegate: AnyObject {
    func didPressTrackedButton()
}

// MARK: Main Type

class TestViewController: UIViewController, TestViewControllerDelegate {
    
    func didPressTrackedButton() {
        var good: String?
    }
    

    // MARK: Type Aliases

    // MARK: Classes

    // MARK: Structs

    // MARK: Enums

    // MARK: Stored Type Properties

    // MARK: Stored Instance Properties

    // MARK: Computed Instance Properties

    // MARK: IBOutlets

    // MARK: Initializers

    // MARK: Type Methods

    // MARK: View Life-Cycle Methods

    // MARK: IBActions

    // MARK: TestViewControllerDelegate

    // MARK: Other Methods

    // MARK: Subscripts

}

// MARK: Extensions

extension TestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
