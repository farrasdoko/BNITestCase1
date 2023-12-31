//
//  HomeRouter.swift
//  TestFarras
//
//  Created by Farras on 22/09/23.
//

import Foundation
import UIKit

protocol HomeRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func pushToQRScreen(from vc: UIViewController?)
}

class HomeRouter: HomeRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = HomeVC()
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    // MARK: Presenter to Router
    func pushToQRScreen(from vc: UIViewController?) {
        let QrVc = QRCodeScannerRouter.createModule()
        let nav = UINavigationController(rootViewController: QrVc)
        
        vc?.present(nav, animated: true)
    }
}
