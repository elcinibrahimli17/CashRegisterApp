//
//  KasaCardView.swift
//  CashRegister
//
//  Created by Elchın on 28.03.26.
//

import UIKit

class KasaCardView: BaseView {
    
    private let subtitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Mövcud kassa"
        label.textColor = UIColor(white: 1, alpha: 0.8)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let totalAmountLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 38, weight: .bold)
        return label
    }()
    
    private lazy var statsStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [girenCard, cikanCard, netCard])
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 8
        return view
    }()
    
    let girenCard = StatCardView()
    let cikanCard = StatCardView()
    let netCard   = StatCardView()
    
    override func setupView() {
        super.setupView()
        setupUI()
    }
    
    private func setupUI() {
        
        backgroundColor = UIColor(red: 0.29, green: 0.72, blue: 0.45, alpha: 1.0) // #4AB873
        layer.cornerRadius = 20

        let mainStack = UIStackView(arrangedSubviews: [subtitleLabel, totalAmountLabel, statsStackView])
        mainStack.axis = .vertical
        mainStack.spacing = 8
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func update(item: CardDataModel) {
        let amountFormat = String(format: "%.2f", item.totalAmount)
        totalAmountLabel.text = amountFormat
        
        let inAmount = String(format: "%.2f", item.incomeAmount)
        let exAmount = String(format: "%.2f", item.expanseAmount)
        let netAmount = String(format: "%.2f", item.netAmount)
        
        girenCard.updateInfo(title: "Girən", amount: inAmount)
        cikanCard.updateInfo(title: "Çıxan", amount: exAmount)
        netCard.updateInfo(title: "Net", amount: netAmount)
    }
}
