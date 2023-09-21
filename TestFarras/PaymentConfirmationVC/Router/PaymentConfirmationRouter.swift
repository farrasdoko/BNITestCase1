//
//  PaymentConfirmationRouter.swift
//  TestFarras
//
//  Created by Farras on 22/09/23.
//

import Foundation
import UIKit

protocol PaymentConfirmationRouterProtocol: AnyObject {
    static func createModule(payment: Payment) -> UIViewController
    
    // MARK: Presenter to Router
    func dismissCurrentVc(vc: UIViewController, completion: @escaping () -> Void)
}

class PaymentConfirmationRouter: PaymentConfirmationRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule(payment: Payment) -> UIViewController {
        let view = PaymentConfirmationVC(paymentData: payment)
        let interactor = PaymentConfirmationInteractor()
        let presenter = PaymentConfirmationPresenter()
        let router = PaymentConfirmationRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func dismissCurrentVc(vc: UIViewController, completion: @escaping () -> Void) {
        vc.dismiss(animated: true, completion: completion)
    }
}
