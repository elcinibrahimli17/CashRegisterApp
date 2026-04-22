//
//  StatCardView.swift
//  CashRegister
//
//  Created by Nahid Habibov on 04.04.26.
//

import UIKit

class StatCardView: BaseView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 1, alpha: 0.75)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "0.00"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    override func setupView() {
        super.setupView()
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = UIColor(white: 1, alpha: 0.15)
        layer.cornerRadius = 12
        let stack = UIStackView(arrangedSubviews: [titleLabel, amountLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
    
    func updateInfo(title: String, amount: String) {
        titleLabel.text = title
        amountLabel.text = amount
    }
}
