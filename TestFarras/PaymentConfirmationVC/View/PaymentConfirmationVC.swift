//
//  PaymentConfirmationVC.swift
//  TestFarras
//
//  Created by Farras on 19/09/23.
//

import UIKit

protocol PaymentConfirmationViewProtocol: AnyObject {
    var presenter: PaymentConfirmationPresenterProtocol? { get set }
    
    // MARK: Presenter to View
    func setupData(with data: Payment)
    func showSuccessAlert()
}

class PaymentConfirmationVC: UIViewController {
    
    var presenter: PaymentConfirmationPresenterProtocol?
    
    private var transactionIdLabel: BNILabel!
    private var recipientLabel: BNILabel!
    private var merchantNameLabel: BNILabel!
    private var nominalLabel: BNILabel!
    private var confirmButton: BNIButton!
    
    var data: Payment
    
    init(paymentData: Payment) {
        self.data = paymentData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var transactionId: String {
        get {
            data.transactionId
        }
        set {
            transactionIdLabel.text = "Transaction ID: "+(newValue )
            data.transactionId = newValue
        }
    }
    private var recipient: String {
        get {
            data.recipient
        }
        set {
            recipientLabel.text = "Recipient: "+(newValue )
            data.recipient = newValue
        }
    }
    private var merchant: String {
        get {
            data.merchant
        }
        set {
            merchantNameLabel.text = "Merchant: "+(newValue )
            data.merchant = newValue
        }
    }
    private var nominal: Int {
        get {
            data.nominal
        }
        set {
            nominalLabel.text = "Nominal: "+(newValue.asIdr ?? "")
            data.nominal = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        presenter?.viewDidLoad(payment: data)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        let stack = BNIStackView(axis: .vertical)
        view.addSubview(stack)
        stack.insertConstraint(.centerX(margin: 0), .centerY(margin: 0))
        
        transactionIdLabel = setupLabel()
        recipientLabel = setupLabel()
        merchantNameLabel = setupLabel()
        nominalLabel = setupLabel()
        
        confirmButton = setupConfirmButton()
        view.addSubview(confirmButton)
        NSLayoutConstraint.activate([
            confirmButton.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: confirmButton.trailingAnchor),
            confirmButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 36),
        ])
        confirmButton.insertConstraint(.heightConstant(height: 36))
        
        stack.addArrangedSubviews(transactionIdLabel, recipientLabel, merchantNameLabel, nominalLabel)
    }
    
    private func setupConfirmButton() -> BNIButton {
        let confirmButton = BNIButton()
        confirmButton.setTitle("Confirm Payment", for: .normal)
        confirmButton.backgroundColor = .primaryColor
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.layer.cornerRadius = 5
        confirmButton.addTarget(self, action: #selector(confirmButtonClicked), for: .touchUpInside)
        return confirmButton
    }
    
    @objc private func confirmButtonClicked() {
        // Prevent user from double click.
        confirmButton.isEnabled = false
        presenter?.confirmButtonClicked(data: data, vc: self)
    }
    
    private func setupLabel() -> BNILabel {
        let balanceLabel = BNILabel()
        balanceLabel.textColor = .black
        return balanceLabel
    }
    
}

extension PaymentConfirmationVC: PaymentConfirmationViewProtocol {
    func setupData(with data: Payment) {
        transactionId = data.transactionId
        recipient = data.recipient
        merchant = data.merchant
        nominal = data.nominal
    }
    func showSuccessAlert() {
        UIAlertController.showAlert(title: "Success", message: "Payment completed.", style: .alert)
    }
}
