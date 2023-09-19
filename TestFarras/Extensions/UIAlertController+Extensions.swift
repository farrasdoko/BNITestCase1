//
//  UIAlertController+Extensions.swift
//  TestFarras
//
//  Created by Farras on 19/09/23.
//

import UIKit

extension UIAlertController {
    class func showAlert(title: String?, message: String?, style: Style, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(okAction)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let viewController = windowScene.windows.first?.rootViewController {
                viewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
