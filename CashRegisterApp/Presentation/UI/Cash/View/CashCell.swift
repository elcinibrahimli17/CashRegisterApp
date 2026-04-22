//
//  CashCell.swift
//  CashRegister
//
//  Created by Elchın on 02.04.26.
//

import UIKit

class CashCell: BaseCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupView() {
        super.setupView()
        setupUIConstraints()
    }
    
    private func setupUIConstraints() {
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.heightAnchor.constraint(equalToConstant: 18),
            
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 18),
            
        ])
    }
    
    func cellConfig(item: TransactionModel ) {
        nameLabel.text = item.name
        
        switch item.type {
        case .income:
            priceLabel.textColor = .green
            priceLabel.text = "+\(item.amount)"
        case .expense:
            priceLabel.textColor = .red
            priceLabel.text = "-\(item.amount)"
        }
    }
}
