//
//  OpeningViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//
//provisioningfileメモ
//実機でビルドするときは「development」を利用し、apppstoreへ申請の際は「distribution」を使用する。


import UIKit
import Lottie

var userPass = String()

class OpeningViewController: UIViewController {
    
    @IBOutlet var didTapToNextButton:UIButton!
    let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "userPass") != nil {
            userPass = UserDefaults.standard.object(forKey: "userPass") as! String
        }
        
       startOpeningAnimation()
       view.backgroundColor = UIColor.flatMint()
       self.navigationController?.isNavigationBarHidden = true
    }
    
    func startOpeningAnimation(){
        let path = Bundle.main.path(forResource:"10685-breakfast", ofType:"json")
        let animationView = AnimationView(filePath: path!)
        animationView.animationSpeed = 1.0
        animationView.center = self.view.center
      animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - didTapToNextButton.frame.size.height)
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }
    
    @IBAction func nextButton(sender:UIButton){
        
        if UserDefaults.standard.object(forKey: "userPass") != nil {
            userPass = UserDefaults.standard.object(forKey: "userPass") as! String
            performSegue(withIdentifier: "toSearch", sender: nil)

        } else {
           performSegue(withIdentifier: "toRegister", sender: nil)
        }
    }
    }

