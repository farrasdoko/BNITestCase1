//
//  Int+Extensions.swift
//  TestFarras
//
//  Created by Farras on 20/09/23.
//

import UIKit

extension Int {
    // returns `Rp `
    var asIdr: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "id_ID")
        return numberFormatter.string(from: NSNumber(value: self))
    }
}
