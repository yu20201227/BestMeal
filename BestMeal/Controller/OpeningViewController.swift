//
//  OpeningViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/12.
//

import UIKit
import Lottie

class OpeningViewController: UIViewController {
    
    @IBOutlet var didTapToNextButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       startOpeningAnimation()
        view.backgroundColor = UIColor.flatMint()
        self.navigationController?.isNavigationBarHidden = true

    }

    func startOpeningAnimation(){
        let path = Bundle.main.path(forResource: "10685-breakfast", ofType: "json")
        let animationView = AnimationView()
        animationView.animationSpeed = 1.0
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - didTapToNextButton.frame.size.height)
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
}
    
    @IBAction func nextButton(sender:Any){
        performSegue(withIdentifier: "toRegister", sender: nil)
    }
}
