//
//  HomeVC.swift
//  TestFarras
//
//  Created by Farras on 19/09/23.
//

import UIKit

class HomeVC: UIViewController {
    
    private var headerView: HeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        headerView = setupHeaderView()
    }
    
    private func setupHeaderView() -> HeaderView {
        let headerView = HeaderView()
        view.addSubview(headerView)
        
        let headerViewMargin: CGFloat = 8
        headerView.insertConstraint(.leading(margin: headerViewMargin), .top(margin: headerViewMargin), .trailing(margin: headerViewMargin), .heightConstant(height: 128))
        
        return headerView
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
        private var balanceValueLabel: BNILabel!
        private var headerStackView: BNIStackView!
        private var headerImageView: BNIImageView!
        
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
            let moneyDollarImg = UIImage(named: "money_dollar_circle_fill")
            let imgView = BNIImageView()
            imgView.image = moneyDollarImg
            addSubview(imgView)
            
            let imgViewMargin: CGFloat = 8
            imgView.insertConstraint(.trailing(margin: imgViewMargin), .centerY(margin: 0))
            
            NSLayoutConstraint.activate([
                imgView.leadingAnchor.constraint(greaterThanOrEqualTo: headerStackView.trailingAnchor, constant: imgViewMargin),
            ])
            
            return imgView
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
            balanceLabel.text = "5.00g"
            balanceLabel.textColor = .white
            balanceLabel.font = .boldSystemFont(ofSize: 24)
            return balanceLabel
        }
    }
}
