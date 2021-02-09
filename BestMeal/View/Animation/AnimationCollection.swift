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
        let path = Bundle.main.path(forResource: "10685-breakfast", ofType:"json")
        let animationView = AnimationView(filePath: path!)
        animationView.animationSpeed = 1.0
        animationView.center = self.view.center
        animationView.frame =
            CGRect(x: 0, y: 0, width: view.frame.size.width,
                   height: view.frame.size.height - didTapToNextButton.frame.size.height)
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }
}
