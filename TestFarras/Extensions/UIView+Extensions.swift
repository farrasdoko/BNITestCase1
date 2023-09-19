//
//  UIView+Extensions.swift
//  TestFarras
//
//  Created by Farras on 19/09/23.
//

import UIKit

extension UIView {
    enum ConstraintDirection {
        case top(margin: CGFloat)
        case leading(margin: CGFloat)
        case trailing(margin: CGFloat)
        case bottom(margin: CGFloat)
        case centerY(margin: CGFloat)
        case centerX(margin: CGFloat)
        case heightConstant(height: CGFloat)
        case widthConstant(width: CGFloat)
    }
    func insertConstraint(_ directions: ConstraintDirection...) {
        guard let superview = superview else {
            print("can't insert constraint on \(Self.self) superview not found")
            return
        }
        var constraintsToBeActivated: [NSLayoutConstraint] = []
        for direction in directions {
            switch direction {
            case .top(let margin):
                let cons = topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: margin)
                constraintsToBeActivated.append(cons)
            case .leading(let margin):
                let cons = leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor, constant: margin)
                constraintsToBeActivated.append(cons)
            case .trailing(let margin):
                let cons = superview.layoutMarginsGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: margin)
                constraintsToBeActivated.append(cons)
            case .bottom(let margin):
                let cons = bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: margin)
                constraintsToBeActivated.append(cons)
            case .centerY(let margin):
                let cons = centerYAnchor.constraint(equalTo: superview.layoutMarginsGuide.centerYAnchor, constant: margin)
                constraintsToBeActivated.append(cons)
            case .centerX(let margin):
                let cons = centerXAnchor.constraint(equalTo: superview.layoutMarginsGuide.centerXAnchor, constant: margin)
                constraintsToBeActivated.append(cons)
            case .heightConstant(let height):
                let cons = heightAnchor.constraint(equalToConstant: height)
                constraintsToBeActivated.append(cons)
            case .widthConstant(let width):
                let cons = widthAnchor.constraint(equalToConstant: width)
                constraintsToBeActivated.append(cons)
            }
        }
        NSLayoutConstraint.activate(constraintsToBeActivated)
    }
}
