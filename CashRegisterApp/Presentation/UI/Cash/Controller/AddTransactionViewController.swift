//
//  AddTransactionViewController.swift
//  CashRegister
//
//  Created by Elchın on 28.03.26.
//

import UIKit
import AnchorKit

class AddTransactionViewController: UIViewController {
    
    private let segmentedControl: UISegmentedControl = {
        let items = ["🟢⬆️ Satış", "🔴⬇️ Alış"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    private let incomeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        label.text = "Daxil olan məbləğ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var amountTextField: CurrencyTextField = {
        let textField = CurrencyTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let expenseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        label.text = "Açıqlama"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descTextField: CurrencyTextField = {
        let textField = CurrencyTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        label.text = "Tarix Seç"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateTimeTextField: CurrencyTextField = {
        let textField = CurrencyTextField()
        textField.inputAccessoryView = dateTimePicker
        textField.addTarget(self, action: #selector(didTapSelectionToDay), for: .touchDown)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var dateTimePicker: UIDatePicker = {
       let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(didTapDateTime(_:)), for: .valueChanged)
        return datePicker
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Günə başla", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.18, green: 0.65, blue: 0.47, alpha: 1.0)
        button.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var viewModel: AddTransactionViewModel = {
       let vm = AddTransactionViewModel()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Yeni Əməliyyat"
        
        

        setupUIConstraints()
        setupActions()
    }
    
    @objc private func didTapSave() {
        guard let text = amountTextField.text,
              let amount = Double(text) else { return }
        
        let type: TransactionType = segmentedControl.selectedSegmentIndex == 0 ? .income : .expense
        
        let description = descTextField.text ?? ""
        
        viewModel.updateTransaction(description: description, amount: amount, type: type)
        
        navigationController?.popViewController(animated: true)
        
    }
    
    private func setupUIConstraints() {
        
        view.anchor(view: segmentedControl) { kit in
            kit.top(safe: true)
            kit.leading(24)
            kit.trailing(24)
        }
        
        view.anchor(view: incomeLabel) { kit in
            kit.top(segmentedControl.bottomAnchor, 16)
            kit.leading(16)
            kit.trailing(16)
            kit.height(30)
        }
        
        view.anchor(view: amountTextField) { kit in
            kit.top(incomeLabel.bottomAnchor, 8)
            kit.leading(incomeLabel.leadingAnchor)
            kit.trailing(incomeLabel.trailingAnchor)
            kit.height(40)
        }
        
        view.anchor(view: expenseLabel) { kit in
            kit.top(amountTextField.bottomAnchor, 16)
            kit.leading(amountTextField.leadingAnchor)
            kit.trailing(amountTextField.trailingAnchor)
            kit.height(incomeLabel.heightAnchor)
        }
        
        view.anchor(view: descTextField) { kit in
            kit.top(expenseLabel.bottomAnchor, 8)
            kit.leading(expenseLabel.leadingAnchor)
            kit.trailing(expenseLabel.trailingAnchor)
            kit.height(40)
        }
        
        view.anchor(view: dateLabel) { kit in
            kit.top(descTextField.bottomAnchor, 16)
            kit.leading(descTextField.leadingAnchor)
            kit.trailing(descTextField.trailingAnchor)
            kit.height(expenseLabel.heightAnchor)
        }
        
        view.anchor(view: dateTimeTextField) { kit in
            kit.top(dateLabel.bottomAnchor, 8)
            kit.leading(dateLabel.leadingAnchor)
            kit.trailing(dateLabel.trailingAnchor)
            kit.height(40)
        }
        
        view.anchor(view: saveButton) { kit in
            kit.top(dateTimeTextField.bottomAnchor, 16)
            kit.leading(dateTimeTextField.leadingAnchor)
            kit.trailing(dateTimeTextField.trailingAnchor)
            kit.height(40)
        }
    }
    
    private func setupActions() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHidePicker)))
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    @objc private func didTapSelectionToDay() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateTimeTextField.text = formatter.string(from: .now)
        viewModel.updateDate(date: .now)
    }
    
    @objc private func didTapHidePicker() {
        view.endEditing(false)
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            incomeLabel.text = "Daxil olan məbləğ"

        case 1:
            incomeLabel.text = "Xaric olan məbləğ"

        default:
            break
        }
    }

    @objc private func didTapDateTime(_ picker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateTimeTextField.text = formatter.string(from: picker.date)
        viewModel.updateDate(date: picker.date)
    }
}


