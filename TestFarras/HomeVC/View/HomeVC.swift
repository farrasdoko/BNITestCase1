//
//  HomeVC.swift
//  TestFarras
//
//  Created by Farras on 19/09/23.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    
    // MARK: Presenter to View
    func refreshBalance(balance: String?, transactionData: [Transaction])
}


class HomeVC: UIViewController {
    
    var presenter: HomePresenterProtocol?
    
    private var headerView: HeaderView!
    private let tableView = UITableView()
    private let transactionCellIdentifier = "TransactionCell"
    
    private var transactionsData: [Transaction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.viewDidAppear()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        headerView = setupHeaderView()
        setupQrImageTapped()
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: transactionCellIdentifier)
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let margin: CGFloat = 8
        tableView.insertConstraint(.top(margin: margin), .leading(margin: margin), .trailing(margin: margin))
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: margin)
        ])
    }
    
    private func setupHeaderView() -> HeaderView {
        let headerView = HeaderView()
        view.addSubview(headerView)
        
        let headerViewMargin: CGFloat = 8
        headerView.insertConstraint(.leading(margin: headerViewMargin), .bottom(margin: headerViewMargin), .trailing(margin: headerViewMargin), .heightConstant(height: 128))
        
        return headerView
    }
    
    private func setupQrImageTapped() {
        headerView.didTapQrImage = { [weak self] in
            self?.presenter?.showQRController(from: self)
        }
    }
    
    private class HeaderView: UIView {
        
        var cornerRadius: CGFloat {
            get {
                layer.cornerRadius
            }
            set {
                layer.cornerRadius = newValue
            }
        }
        
        private var balanceTitleLabel: BNILabel!
        var balanceValueLabel: BNILabel!
        private var headerStackView: BNIStackView!
        private var headerImageView: BNIImageView!
        
        var didTapQrImage: (() -> Void)?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.setupUI()
        }
        required init?(coder: NSCoder) {
            fatalError("Please use another initializer")
        }
        
        private func setupUI() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.backgroundColor = .primaryColor
            self.cornerRadius = 16
            
            balanceTitleLabel = setupBalanceTitleLabel()
            balanceValueLabel = setupBalanceValueLabel()
            
            headerStackView = setupHeaderStackView()
            headerImageView = setupHeaderImageView()
        }
        
        private func setupHeaderImageView() -> BNIImageView {
            let moneyDollarImg = UIImage(systemName: "qrcode.viewfinder")
            let imgView = BNIImageView()
            imgView.tintColor = .yellow
            imgView.image = moneyDollarImg
            addSubview(imgView)
            
            let imgViewMargin: CGFloat = 8
            imgView.insertConstraint(.trailing(margin: imgViewMargin), .centerY(margin: 0), .widthConstant(width: 40), .heightConstant(height: 40))
            
            NSLayoutConstraint.activate([
                imgView.leadingAnchor.constraint(greaterThanOrEqualTo: headerStackView.trailingAnchor, constant: imgViewMargin),
            ])
            
            let imgViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(qrImageTapped))
            imgView.addGestureRecognizer(imgViewTapGesture)
            imgView.isUserInteractionEnabled = true
            
            return imgView
        }
        
        @objc private func qrImageTapped() {
            didTapQrImage?()
        }
        
        private func setupHeaderStackView() -> BNIStackView {
            let headerStackView = BNIStackView(axis: .vertical)
            headerStackView.addArrangedSubviews(balanceTitleLabel, balanceValueLabel)
            addSubview(headerStackView)
            
            let stackMargin: CGFloat = 8
            headerStackView.insertConstraint(.leading(margin: stackMargin), .centerY(margin: 0))
            return headerStackView
        }
        
        private func setupBalanceTitleLabel() -> BNILabel {
            let balanceLabel = BNILabel()
            balanceLabel.text = "Your Balance"
            balanceLabel.textColor = .white
            return balanceLabel
        }
        
        private func setupBalanceValueLabel() -> BNILabel {
            let balanceLabel = BNILabel()
            balanceLabel.textColor = .white
            balanceLabel.font = .boldSystemFont(ofSize: 24)
            return balanceLabel
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactionsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: transactionCellIdentifier)!
        
        var content = cell.defaultContentConfiguration()
        content.text = transactionsData[indexPath.row].merchant
        content.secondaryText = transactionsData[indexPath.row].nominal.asIdr
        
        cell.contentConfiguration = content
        return cell
    }
}

extension HomeVC: HomeViewProtocol {
    func refreshBalance(balance: String?, transactionData: [Transaction]) {
        headerView.balanceValueLabel.text = balance
        self.transactionsData = transactionData
        tableView.reloadData()
    }
}
