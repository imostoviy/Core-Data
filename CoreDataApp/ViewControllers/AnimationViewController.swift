//
//  AnimationTableViewController.swift
//  CoreDataApp
//
//  Created by Мостовий Ігор on 2/7/19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit
import Lottie

class AnimationViewController: UIViewController {
    
    private var isAnimating = false
    private let animating = "Tab to stop animation"
    private let notAnimating = "Tap to start animation"
    var positionInterpolator: LOTPointInterpolatorCallback?
    let animation = LOTAnimationView(name: "Animation")
    
    
    @IBOutlet weak var startAnimationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isAnimating = false
        animation.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 250)
        animation.contentMode = .scaleAspectFill
        animation.loopAnimation = true
        let screenCenter = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        let offscreenCenter = CGPoint(x: view.bounds.midX, y: -view.bounds.midY)
        let boatStartPoint = animation.convert(screenCenter, toKeypathLayer: LOTKeypath(string: "Boat"))
        let boatEndPoint = animation.convert(offscreenCenter, toKeypathLayer: LOTKeypath(string: "Boat"))
        positionInterpolator = LOTPointInterpolatorCallback(from: boatStartPoint, to: boatEndPoint)
        animation.setValueDelegate(positionInterpolator!, for: LOTKeypath(string: "Boat.Transform.Position"))
        self.view.addSubview(animation)
        startAnimationButton.addTarget(self, action: #selector(self.controllAnimation), for: .touchUpInside)
    }
    
    @objc private func controllAnimation() {
        if !isAnimating {
            startAnimationButton.titleLabel?.text = animating
            isAnimating = true
            animation.play()
        } else {
            startAnimationButton.titleLabel?.text = notAnimating
            isAnimating = false
            animation.stop()
        }
    }
}
