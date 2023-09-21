//
//  QRCodeScannerInteractor.swift
//  TestFarras
//
//  Created by Farras on 22/09/23.
//

import Foundation

protocol QRCodeScannerInteractorProtocol: AnyObject {
    var presenter: QRCodeScannerPresenterProtocol? { get set }
    
    // MARK: Presenter to Interactor
    func getPayment(from strMetaData: String) -> Payment?
}

class QRCodeScannerInteractor: QRCodeScannerInteractorProtocol {
    var presenter: QRCodeScannerPresenterProtocol?
    
    init(presenter: QRCodeScannerPresenterProtocol? = nil) {
        self.presenter = presenter
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

