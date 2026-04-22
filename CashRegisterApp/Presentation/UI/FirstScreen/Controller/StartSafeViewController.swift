//
//  StartSafeViewController.swift
//  CashRegister
//
//  Created by Elchın on 28.03.26.
//

import UIKit
import AnchorKit

class StartSafeViewController: UIViewController {
    
    private let startSafeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        label.text = "Kassanı başlat"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        label.text = "Bugün kassanda nə qədər pul var?"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let openingBalanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        label.text = "Açılış məbləği"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var balanceTextField: CurrencyTextField = {
        let textField = CurrencyTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var startDayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Günə başla", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.18, green: 0.65, blue: 0.47, alpha: 1.0)
        button.addTarget(self, action: #selector(startADayButton), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    let viewModel: StartSafeViewModel = {
       let vm = StartSafeViewModel()        
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUIConstraints()
    }
    
    @objc private func startADayButton() {
        guard let amountText = balanceTextField.text, !amountText.isEmpty,
        let amount = Double(amountText) else {
            return
        }
        
        guard amount >= 0 else {
            return
        }
        
        viewModel.startCashAmount(amount: amount)
    }
    
    private func setupUIConstraints() {
        view.anchor(view: startSafeLabel) { kit in
            kit.top(24, safe: true)
            kit.leading(16)
            kit.trailing(16)
            kit.height(30)
        }
        
        view.anchor(view: questionLabel) { kit in
            kit.top(startSafeLabel.bottomAnchor, 8)
            kit.leading(startSafeLabel.leadingAnchor)
            kit.trailing(startSafeLabel.trailingAnchor)
            kit.height(startSafeLabel.heightAnchor)
        }
        
        view.anchor(view: openingBalanceLabel) { kit in
            kit.top(questionLabel.bottomAnchor, 16)
            kit.leading(questionLabel.leadingAnchor)
            kit.trailing(questionLabel.trailingAnchor)
            kit.height(questionLabel.heightAnchor)
        }
        
        view.anchor(view: balanceTextField) { kit in
            kit.top(openingBalanceLabel.bottomAnchor, 8)
            kit.leading(openingBalanceLabel.leadingAnchor)
            kit.trailing(openingBalanceLabel.trailingAnchor)
            kit.height(40)
        }
        
        view.anchor(view: startDayButton) { kit in
            kit.top(balanceTextField.bottomAnchor, 16)
            kit.leading(balanceTextField.leadingAnchor)
            kit.trailing(balanceTextField.trailingAnchor)
            kit.height(50)
        }
    }
}
