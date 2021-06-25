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
