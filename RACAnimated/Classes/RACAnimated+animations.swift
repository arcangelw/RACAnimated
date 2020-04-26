//
//  RACAnimated.swift
//  RACAnimated
//
//  Created by 吴哲 on 2019/2/20.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import ReactiveSwift
import ReactiveCocoa
import UIKit

/// custom direction enumeration
public enum FlipDirection {
    case left, right, top, bottom
    
    var viewTransition: UIView.AnimationOptions {
        switch self {
        case .left: return .transitionFlipFromLeft
        case .right: return .transitionFlipFromRight
        case .top: return .transitionFlipFromTop
        case .bottom: return .transitionFlipFromBottom
        }
    }
}

// MARK: - built-in animations

extension AnimatedSink where Base: UIView {
    /// cross-dissolve animation on `UIView`
    public func fade(duration: TimeInterval) -> AnimatedSink<Base> {
        let type = AnimationType<Base>(type: .transition(.transitionCrossDissolve), duration: duration, animations: nil)
        return AnimatedSink<Base>(base: self.base, type: type)
    }
    
    /// flip animation on `UIView`
    public func flip(_ direction: FlipDirection, duration: TimeInterval) -> AnimatedSink<Base> {
        let type = AnimationType<Base>(type: .transition(direction.viewTransition), duration: duration, animations: nil)
        return AnimatedSink<Base>(base: self.base, type: type)
    }
    
    /// example of extending RacAnimated with a custom animation
    public func tick(_ direction: FlipDirection = .right, duration: TimeInterval) -> AnimatedSink<Base> {
        let type = AnimationType<Base>(type: .spring(damping: 0.33, velocity: 0), duration: duration, setup: { view in
            view.alpha = 0
            view.transform = CGAffineTransform(rotationAngle: direction == .right ?  -0.3 : 0.3)
        }, animations: { view in
            view.alpha = 1
            view.transform = CGAffineTransform.identity
        })
        return AnimatedSink<Base>(base: self.base, type: type)
    }
    
    public func animation(duration: TimeInterval, options: UIView.AnimationOptions = [], animations: @escaping ()->Void) -> AnimatedSink<Base> {
        let type = AnimationType<Base>(type: .animation, duration: duration, animations: { _ in animations() })
        return AnimatedSink<Base>(base: self.base, type: type)
    }
}

extension AnimatedSink where Base: NSLayoutConstraint {
    /// auto layout animations
    public func layout(duration: TimeInterval) -> AnimatedSink<Base> {
        let type = AnimationType<Base>(type: .animation, duration: duration, animations: { view in
            view.layoutIfNeeded()
        })
        return AnimatedSink<Base>(base: self.base, type: type)
    }
}
