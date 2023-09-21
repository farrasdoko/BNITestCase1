//
//  PaymentConfirmationPresenter.swift
//  TestFarras
//
//  Created by Farras on 22/09/23.
//

import Foundation
import UIKit

protocol PaymentConfirmationPresenterProtocol: AnyObject {
    var view: PaymentConfirmationViewProtocol? { get set }
    var interactor: PaymentConfirmationInteractorProtocol? { get set }
    var router: PaymentConfirmationRouterProtocol? { get set }
    
    // MARK: View to Presenter
    func viewDidLoad(payment: Payment)
    func confirmButtonClicked(data: Payment, vc: UIViewController)
    
    // MARK: Interactor to Presenter
}

class PaymentConfirmationPresenter: PaymentConfirmationPresenterProtocol {
    weak var view: PaymentConfirmationViewProtocol?
    var interactor: PaymentConfirmationInteractorProtocol?
    var router: PaymentConfirmationRouterProtocol?
    
    func confirmButtonClicked(data: Payment, vc: UIViewController) {
        interactor?.performTransactionOnMainUser(data: data)
        router?.dismissCurrentVc(vc: vc) { [weak self] in
            self?.view?.showSuccessAlert()
        }
    }
    
    func viewDidLoad(payment: Payment) {
        view?.setupData(with: payment)
    }
}

