//
//  AnimationCollection.swift
//  BestMeal
//
//  Created by Owner on 2021/02/07.
//

import Foundation
import Lottie

extension OpeningViewController {
    
    public func startOpeningAnimation() {
        let openingAnimationPath = Bundle.main.path(forResource: ForSourceType.openingAnimation, ofType: FileType.jsonType)
        let animationView = AnimationView(filePath: openingAnimationPath!)
        animationView.animationSpeed = 1.0
        animationView.center = self.view.center
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }
}

extension RegisterViewController {
    public func registerPermittedAnimation() {
        
        let permitAnimationPath = Bundle.main.path(forResource: ForSourceType.registerPermitAnimation, ofType: FileType.jsonType)
        let animationView = AnimationView(filePath: permitAnimationPath!)
        animationView.animationSpeed = 1.0
        animationView.center = self.view.center
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        animationView.loopMode = .playOnce
        animationView.play() 
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) { [unowned self] in
            UserDefaults.standard.set(userEmailTextField.text, forKey: UserDefaultForKey.userEmail)
            UserDefaults.standard.set(passTextField.text, forKey: UserDefaultForKey.userPass)
            self.performSegue(withIdentifier: SegueIdentifier.toSearch, sender: nil)
        }
        view.addSubview(animationView)
    }
    
}

