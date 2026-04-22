//
//  CurrencyTextField.swift
//  CashRegister
//
//  Created by Elchın on 28.03.26.
//

import UIKit

final class CurrencyTextField: UITextField {

    private let symbolLabel = UILabel()
    private let innerPadding: CGFloat = 16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = UIColor.systemGray6
        layer.cornerRadius = 14
        layer.masksToBounds = true
        borderStyle = .none
        keyboardType = .decimalPad
        font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textColor = .label
        tintColor = .systemGreen

        setupSymbolView()
    }

    private func setupSymbolView() {

        symbolLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        symbolLabel.textColor = .label
        symbolLabel.sizeToFit()

        let containerWidth = symbolLabel.frame.width + innerPadding + 6
        let container = UIView(frame: CGRect(x: 0, y: 0, width: containerWidth, height: 0))
        symbolLabel.frame.origin.x = innerPadding
        container.addSubview(symbolLabel)

        leftView = container
        leftViewMode = .always

        rightView = UIView(frame: CGRect(x: 0, y: 0, width: innerPadding, height: 0))
        rightViewMode = .always
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 56)
    }
}
