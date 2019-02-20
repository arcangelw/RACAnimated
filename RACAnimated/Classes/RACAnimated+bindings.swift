//
//  RACAnimated.swift
//  RACAnimated
//
//  Created by 吴哲 on 2019/2/20.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import ReactiveSwift
import ReactiveCocoa

// MARK: - Reactive ext on UIView

extension Reactive where Base: UIView {
    /// adds animated bindings to view classes under `rac.animated`
    public var animated: AnimatedSink<Base> {
        return AnimatedSink<Base>(base: self.base)
    }
}

// MARK: - UIView
extension AnimatedSink where Base: UIView {
    public var isHidden: BindingTarget<Bool> {
        return base.reactive.makeBindingTarget { view, hidden in
            self.type.animate(view: view, binding: {
                view.isHidden = hidden
            })
        }
    }
}

extension AnimatedSink where Base: UIView {
    public var alpha: BindingTarget<CGFloat> {
        return base.reactive.makeBindingTarget { view, alpha in
            self.type.animate(view: view, binding: {
                view.alpha = alpha
            })
        }
    }
}

// MARK: - UILabel
extension AnimatedSink where Base: UILabel {
    public var text: BindingTarget<String> {
        return base.reactive.makeBindingTarget { label, text in
            self.type.animate(view: label, binding: {
                label.text = text
            })
        }
    }
    public var attributedText: BindingTarget<NSAttributedString> {
        return base.reactive.makeBindingTarget { label, text in
            self.type.animate(view: label, binding: {
                label.attributedText = text
            })
        }
    }
}

// MARK: - UIControl
extension AnimatedSink where Base: UIControl {
    public var isEnabled: BindingTarget<Bool> {
        return base.reactive.makeBindingTarget { control, enabled in
            self.type.animate(view: control, binding: {
                control.isEnabled = enabled
            })
        }
    }
    public var isSelected: BindingTarget<Bool> {
        return base.reactive.makeBindingTarget { control, selected in
            self.type.animate(view: control, binding: {
                control.isSelected = selected
            })
        }
    }
}

// MARK: - UIButton
extension AnimatedSink where Base: UIButton {
    public var title: BindingTarget<String> {
        return base.reactive.makeBindingTarget { button, title in
            self.type.animate(view: button, binding: {
                button.setTitle(title, for: button.state)
            })
        }
    }
    public var image: BindingTarget<UIImage?> {
        return base.reactive.makeBindingTarget { button, image in
            self.type.animate(view: button, binding: {
                button.setImage(image, for: button.state)
            })
        }
    }
    public var backgroundImage: BindingTarget<UIImage?> {
        return base.reactive.makeBindingTarget { button, image in
            self.type.animate(view: button, binding: {
                button.setBackgroundImage(image, for: button.state)
            })
        }
    }
}

// MARK: - UIImageView
extension AnimatedSink where Base: UIImageView {
    public var image: BindingTarget<UIImage?> {
        return base.reactive.makeBindingTarget { imageView, image in
            self.type.animate(view: imageView, binding: {
                imageView.image = image
            })
        }
    }
}

// MARK: - Reactive ext on NSLayoutConstraint
extension Reactive where Base: NSLayoutConstraint {
    /// adds animated bindings to view classes under `rac.animated`
    public var animated: AnimatedSink<Base> {
        return AnimatedSink<Base>(base: self.base)
    }
}

// MARK: - NSLayoutConstraint
extension AnimatedSink where Base: NSLayoutConstraint {
    public var constant: BindingTarget<CGFloat> {
        return base.reactive.makeBindingTarget { constraint, constant in
            guard let view = constraint.firstItem as? UIView,
                let superview = view.superview else { return }

            self.type.animate(view: superview, binding: {
                constraint.constant = constant
            })
        }
    }
    public var isActive: BindingTarget<Bool> {
        return base.reactive.makeBindingTarget { constraint, active in
            guard let view = constraint.firstItem as? UIView,
                let superview = view.superview else { return }

            self.type.animate(view: superview, binding: {
                constraint.isActive = active
            })
        }
    }
}
