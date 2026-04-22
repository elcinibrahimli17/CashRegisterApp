//
//  TransactionProcessModel.swift
//  CashRegisterApp
//
//  Created by Nahid Habibov on 15.04.26.
//

import Foundation

struct TransactionProcessModel: Codable {
    var totalAmount: Double
    var incomeAmount: Double
    var expanseAmount: Double
    var netAmount: Double
    var data: [TransactionModel]
    var date: Date
}
