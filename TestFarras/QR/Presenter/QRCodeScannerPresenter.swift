//
//  QRCodeScannerPresenter.swift
//  TestFarras
//
//  Created by Farras on 22/09/23.
//

import Foundation
import UIKit

protocol QRCodeScannerPresenterProtocol: AnyObject {
    var view: QRCodeScannerViewProtocol? { get set }
    var interactor: QRCodeScannerInteractorProtocol? { get set }
    var router: QRCodeScannerRouterProtocol? { get set }
    
    // MARK: View to Presenter
    func viewDidLoad()
    func viewDidAppear()
    func viewDidDisappear()
    func showConfirmPaymentController(navigationController: UINavigationController?, metadataString: String)
    
    // MARK: Interactor to Presenter
}

class QRCodeScannerPresenter: QRCodeScannerPresenterProtocol {
    weak var view: QRCodeScannerViewProtocol?
    var interactor: QRCodeScannerInteractorProtocol?
    var router: QRCodeScannerRouterProtocol?
    
    func viewDidLoad() {
    }
    
    func viewDidAppear() {
        view?.startCaptureSession()
    }
    
    func viewDidDisappear() {
        view?.stopCaptureSession()
    }
    
    func showConfirmPaymentController(navigationController: UINavigationController?, metadataString: String) {
        guard let payment = interactor?.getPayment(from: metadataString) else { return }
        router?.pushToConfirmPaymentScreen(navigationController: navigationController, payment: payment)
    }
}
