//
//  BNILabel.swift
//  TestFarras
//
//  Created by Farras on 19/09/23.
//

import UIKit

class BNILabel: UILabel {
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
