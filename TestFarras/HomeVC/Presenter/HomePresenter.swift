//
//  HomePresenter.swift
//  TestFarras
//
//  Created by Farras on 22/09/23.
//

import Foundation
import UIKit

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    // MARK: View to Presenter
    func viewDidLoad()
    func viewDidAppear()
    func showQRController(from vc: UIViewController?)
    
    // MARK: Interactor to Presenter
    func updateUserBalance(balance: String?, transactionData: [Transaction])
}

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    
    func viewDidLoad() {
        observeBalanceChanged()
    }
    
    func viewDidAppear() {
        interactor?.fetchUserBalance()
    }
    
    private func observeBalanceChanged() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshBalance), name: NSNotification.Name.BalanceDidChange, object: nil)
    }
    
    @objc private func refreshBalance() {
        interactor?.fetchUserBalance()
    }
    
    func updateUserBalance(balance: String?, transactionData: [Transaction]) {
        view?.refreshBalance(balance: balance, transactionData: transactionData)
    }
    
    func showQRController(from vc: UIViewController?) {
        router?.pushToQRScreen(from: vc)
    }
    
//    func showDetailController(navigationController: UINavigationController?, promo: Promo) {
//        router?.pushToDetailScreen(navigationController: navigationController, promo: promo)
//    }
}
