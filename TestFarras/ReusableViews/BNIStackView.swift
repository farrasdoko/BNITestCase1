//
//  BNIStackView.swift
//  TestFarras
//
//  Created by Farras on 19/09/23.
//

import UIKit

class BNIStackView: UIStackView {
    init(axis: NSLayoutConstraint.Axis = .horizontal,
         spacing: CGFloat = 0.0,
         alignment: UIStackView.Alignment = .fill,
         distribution: UIStackView.Distribution = .fill) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addArrangedSubviews(_ views: UIView...) {
        for v in views {
            addArrangedSubview(v)
        }
    }
    
    func removeAllArrangedSubviews() {
        for arrangedSubview in arrangedSubviews {
            removeArrangedSubview(arrangedSubview)
        }
    }
}
