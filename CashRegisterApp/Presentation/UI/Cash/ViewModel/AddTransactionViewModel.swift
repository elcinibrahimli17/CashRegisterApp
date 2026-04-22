//
//  AddTransactionViewModel.swift
//  CashRegister
//
//  Created by Elchın on 03.04.26.
//

import Foundation

protocol AddTransactionViewModelDataSource: AnyObject {
    func createItem(model: TransactionModel)
}

class AddTransactionViewModel {
    
    weak var dataSource: AddTransactionViewModelDataSource?
    
    private var selectionDate: Date?
    
    func updateTransaction(description: String, amount: Double, type: TransactionType) {
        guard let selectionDate else { return }
        let transactionItem = TransactionModel(date: selectionDate, name: description, amount: amount, type: type)
        dataSource?.createItem(model: transactionItem)
    }
    
    func updateDate(date: Date) {
        self.selectionDate = date
    }
}
