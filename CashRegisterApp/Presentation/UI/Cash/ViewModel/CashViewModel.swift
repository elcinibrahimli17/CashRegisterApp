//
//  CashViewModel.swift
//  CashRegister
//
//  Created by Elchın on 02.04.26.
//

import Foundation

protocol CashViewModelDelegate: AnyObject {
    func didReceive(error: Error)
    func didReceive(item: CardDataModel)
}


final class CashViewModel {
    
    weak var delegate: CashViewModelDelegate?
    
    private let repo: CashRepository
    
    init(repo: CashRepository) {
        self.repo = repo
    }
    
    private let codabelProcess = CodabelProcess()
    
    private var transactionProcessModel: TransactionProcessModel?
    
    func updateCashData(amount: Double) {
        let item = CardDataModel(
            totalAmount: amount,
            incomeAmount: 0,
            expanseAmount: 0,
            netAmount: 0
        )
        delegate?.didReceive(item: item)
        
        saveCashData(totalAmount: amount)
        UserDefaults.standard.checkCashInfo = true
    }
    
    func loadData() {
        guard let data = UserDefaults.standard.saveCashModel else { return }
        repo.getAllTransaction(data: data) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let transactionModel):
                self.transactionProcessModel = transactionModel
                let item = CardDataModel(
                    totalAmount: transactionModel.totalAmount,
                    incomeAmount: transactionModel.incomeAmount,
                    expanseAmount: transactionModel.expanseAmount,
                    netAmount: transactionModel.netAmount
                )
                delegate?.didReceive(item: item)
                
            case .failure(let failure):
                delegate?.didReceive(error: failure)
            }
        }
    }
    
    func createItemTransaction(model: TransactionModel) {
        guard var transactionProcessModel else { return }
        switch model.type {
        case .income:
            transactionProcessModel.totalAmount += model.amount
            transactionProcessModel.incomeAmount += model.amount
        case .expense:
            transactionProcessModel.totalAmount -= model.amount
            transactionProcessModel.expanseAmount -= model.amount
        }
        
        let resultNet = transactionProcessModel.incomeAmount - abs(transactionProcessModel.expanseAmount)
        transactionProcessModel.netAmount = resultNet
        
        transactionProcessModel.data.append(model)
                        
        UserDefaults.standard.saveCashModel = codabelProcess.encode(model: transactionProcessModel)
        loadData()
    }
    
    private func saveCashData(totalAmount: Double) {
        transactionProcessModel = TransactionProcessModel(
            totalAmount: totalAmount,
            incomeAmount: 0,
            expanseAmount: 0,
            netAmount: 0,
            data: [],
            date: .now
        )
        
        UserDefaults.standard.saveCashModel = codabelProcess.encode(model: transactionProcessModel)
    }

    var items: [TransactionModel] {
        return transactionProcessModel?.data ?? []
    }
}
