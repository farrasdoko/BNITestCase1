//
//  PaymentConfirmationInteractor.swift
//  TestFarras
//
//  Created by Farras on 22/09/23.
//

import Foundation

protocol PaymentConfirmationInteractorProtocol: AnyObject {
    var presenter: PaymentConfirmationPresenterProtocol? { get set }
    
    // MARK: Presenter to Interactor
    func getPayment(from strMetaData: String) -> Payment?
    func performTransactionOnMainUser(data: Payment)
}

class PaymentConfirmationInteractor: PaymentConfirmationInteractorProtocol {
    var presenter: PaymentConfirmationPresenterProtocol?
    
    init(presenter: PaymentConfirmationPresenterProtocol? = nil) {
        self.presenter = presenter
    }
    
    func performTransactionOnMainUser(data: Payment) {
        RealmHelper.performTransactionOnMainUser(recipient: data.recipient, merchant: data.merchant, nominal: data.nominal * -1)
    }
    
    func getPayment(from strMetaData: String) -> Payment? {
        let components = strMetaData.components(separatedBy: ".")
        guard components.count == 4 else {return nil}
        
        let payment = Payment(
            transactionId: components[1],
            recipient: components[0],
            merchant: components[2],
            nominal: Int(components[3]) ?? 0)
        return payment
    }
}

