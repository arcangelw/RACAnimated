//
//  ViewController.swift
//  RACAnimated
//
//  Created by arcangelw on 02/20/2019.
//  Copyright (c) 2019 arcangelw. All rights reserved.
//

// images from: http://avatars.adorable.io/

import UIKit
import Result
import ReactiveSwift
import ReactiveCocoa
import RACAnimated

class ViewController: UIViewController {
    
    @IBOutlet var labelFade: UILabel!
    @IBOutlet var labelFlip: UILabel!
    @IBOutlet var labelCustom: UILabel!
    @IBOutlet var imageFlip: UIImageView!
    @IBOutlet var imageBlock: UIImageView!
    
    @IBOutlet var labelAlpha: UILabel!
    @IBOutlet var imageAlpha: UIImageView!
    
    @IBOutlet var labelIsHidden: UILabel!
    @IBOutlet var imageIsHidden: UIImageView!
    
    @IBOutlet var leftConstraint: NSLayoutConstraint!
    @IBOutlet var rightConstraint: NSLayoutConstraint!
    
    private let timer = SignalProducer.timer(interval: .seconds(1), on: QueueScheduler.main).replayLazily(upTo: 1).scan(1) { count, _ in
        count + 1
    }
    
    private let cancel = MutableProperty<Bool>(false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timer = self.timer.take(until: cancel.producer.filter({$0}).map({_ in ()}))
        
        // Animate `text` with a crossfade
        labelFade.reactive.animated.fade(duration: 0.33).text
            <~ timer
                .map {"Text + fade [\($0)]"}

        
        // Animate `text` with a top flip
        labelFlip.reactive.animated.flip(.top, duration: 0.33).text
            <~ timer
                .map {"Text + flip [\($0)]"}
        
        // Animate `text` with a custom animation `tick`, as driver
        labelCustom.reactive.animated.tick(.left, duration: 0.75).text
            <~ timer
                .delay(0.67, on: QueueScheduler.main)
                .map {"Text + custom [\($0)]"}

        // Animate `image` with a custom animation `tick`
        imageFlip.reactive.animated.tick(.right, duration: 1.0).image
            <~ timer
                .scan("adorable1") { _, count in
                    count % 2 == 0 ? "adorable1" : "adorable2"
                }
                .map {UIImage(named: $0)}

        
        // Animate `image` with a custom block
        var angle: CGFloat = 0.0
        imageBlock.reactive.animated.animation(duration: 0.5, animations: { [weak self] in
            angle += 0.2
            self?.imageBlock.transform = CGAffineTransform(rotationAngle: angle)
        }).image
            <~ timer
                .scan("adorable1") { _, count in
                    count % 2 == 0 ? "adorable1" : "adorable2"
                }
                .map {UIImage(named: $0)}
        
        // Animate layout constraint
        leftConstraint.reactive.animated.layout(duration: 0.33).constant
            <~ timer
                .scan(0) { acc, _ in
                    acc == 0 ? 105 : 0
                }
        
        // Activate/Deactivate a constraint
        rightConstraint.reactive.animated.layout(duration: 0.33).isActive
            <~ timer
                .scan(true) { acc, _ in
                    !acc
                }
        
        // Animate `alpha` with a flip
        let timerAlpha = timer.scan(1, { (acc, _) in
            acc > 2 ? 1 : acc + 1
        }).map({CGFloat(1.0 / $0)})

        imageAlpha.reactive.animated.flip(.left, duration: 0.45).alpha <~ timerAlpha
        labelAlpha.reactive.text <~ timerAlpha.map({"alpha: \($0)"})
        
        // Animate `isHidden` with a flip
        let timerHidden = timer.scan(false) { (_, count) in
            count % 2 == 0 ? true : false
        }

        imageIsHidden.reactive.animated.flip(.bottom, duration: 0.45).isHidden <~ timerHidden
        labelIsHidden.reactive.text <~ timerHidden.map({"hidden: \($0)"})
        
        // disable animations when the device is working hard or user is motion sensitive
        RacAnimated.enableDefaultPerformanceHeuristics()

        // disable animations manually
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
            RacAnimated.areAnimationsEnabled.value = false
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 15.0, execute: {
            RacAnimated.areAnimationsEnabled.value = true
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 20.0, execute: {
            self.cancel.value = true
        })
    }
}

