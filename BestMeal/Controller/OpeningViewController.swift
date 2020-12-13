//
//  OpeningViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import UIKit
import Lottie
//still not JSON file from lottie on this project.

class OpeningViewController: UIViewController {
    
    let animationView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
       // startOpeningAnimation()

    }
//
//    func startOpeningAnimation(){
//        let path = Bundle.main.path(forResource: "8683-face-scannning", ofType: "json")
//        let animationView = AnimationView()
//        animationView.animationSpeed = 1.0
//        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
//        animationView.loopMode = .loop
//        animationView.play()
//        view.addSubview(animationView)
//}
    
    @IBAction func nextButton(sender:Any){
        performSegue(withIdentifier: "toRegister", sender: nil)
    }
}
