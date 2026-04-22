//
//  StartSafeViewModel.swift
//  CashRegister
//
//  Created by Elchın on 01.04.26.
//

import Foundation

protocol StartSafeDataSource: AnyObject {
    func updateStartCashAmount(totalAmount: Double)
}

final class StartSafeViewModel {
    
    weak var dataSource: StartSafeDataSource?
    
    func startCashAmount(amount: Double) {        
        dataSource?.updateStartCashAmount(totalAmount: amount)
    }
}
