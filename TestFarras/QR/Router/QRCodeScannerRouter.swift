//
//  QRCodeScannerRouter.swift
//  TestFarras
//
//  Created by Farras on 22/09/23.
//

import Foundation
import UIKit

protocol QRCodeScannerRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    
    // MARK: Presenter to Router
    func pushToConfirmPaymentScreen(navigationController: UINavigationController?, payment: Payment)
}

class QRCodeScannerRouter: QRCodeScannerRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = QRCodeScannerVC()
        let interactor = QRCodeScannerInteractor()
        let presenter = QRCodeScannerPresenter()
        let router = QRCodeScannerRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func pushToConfirmPaymentScreen(navigationController: UINavigationController?, payment: Payment) {
        let vc = PaymentConfirmationRouter.createModule(payment: payment)
        navigationController?.setViewControllers([vc], animated: true)
    }
}
