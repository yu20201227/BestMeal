//
//  AccessFailViewController.swift
//  BestMeal
//
//  Created by Owner on 2020/12/30.
//

import UIKit
import Lottie

class AccessFailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func startSadAnimation(){
        //lottieは重いため最後に回す
        let path = Bundle.main.path(forResource: "", ofType: "")
        let animationView = AnimationView()
        animationView.animationSpeed = 1.0
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        animationView.play()
        view.addSubview(animationView)
    }
    
    @IBAction func tryAgainButton(){
        dismiss(animated: true, completion: nil)
    }


}
