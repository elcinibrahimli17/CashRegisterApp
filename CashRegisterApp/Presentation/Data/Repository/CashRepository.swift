//
//  CashRepository.swift
//  CashRegisterApp
//
//  Created by Nahid Habibov on 15.04.26.
//

import Foundation

final class CashRepository {
    
    private let process = CodabelProcess()
    
    func getAllTransaction(data: Data, completion: @escaping(Result<TransactionProcessModel, Error>) -> Void) {
        process.decode(data: data, completion: completion)
    }
}
