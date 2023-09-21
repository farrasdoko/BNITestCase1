//
//  HomeInteractor.swift
//  TestFarras
//
//  Created by Farras on 22/09/23.
//

import Foundation

protocol HomeInteractorProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    
    // MARK: Presenter to Interactor
    func fetchUserBalance()
}

class HomeInteractor: HomeInteractorProtocol {
    var presenter: HomePresenterProtocol?
    
    init(presenter: HomePresenterProtocol? = nil) {
        self.presenter = presenter
    }
    
    func fetchUserBalance() {
        let mainUserBalance = RealmHelper.getMainUserBalance()?.asIdr
        let transactionData = RealmHelper.getTransactionHistory()
        presenter?.updateUserBalance(balance: mainUserBalance, transactionData: transactionData)
    }
}
