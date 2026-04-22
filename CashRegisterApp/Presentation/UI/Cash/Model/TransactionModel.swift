//
//  TransactionModel.swift
//  CashRegister
//
//  Created by Elchın on 03.04.26.
//

import Foundation

enum TransactionType: Codable {
    case income
    case expense
}

struct TransactionModel: Codable  {
    let date: Date
    let name: String
    let amount: Double
    let type: TransactionType
}
