//
//  HistoryViewModel.swift
//  CashRegisterApp
//
//  Created by Elchın on 21.04.26.
//

import Foundation

protocol HistoryViewModelDelegate: AnyObject {
    func didReceiveReloadData()
    func didReceive(error: Error)
}

final class HistoryViewModel {
    
    weak var delegate: HistoryViewModelDelegate?
    
    private let repo: CashRepository
    
    init(repo: CashRepository) {
        self.repo = repo
    }
    
    private let codabelProcess = CodabelProcess()
    private(set) var allHistory: [TransactionModel] = []
    private var filterdHistory: [TransactionModel] = []

    func loadData() {
        guard let data = UserDefaults.standard.saveCashModel else { return }
        repo.getAllTransaction(data: data) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let transactionModel):
                filterdHistory = transactionModel.data
                delegate?.didReceiveReloadData()
                
            case .failure(let failure):
                delegate?.didReceive(error: failure)
            }
        }
    }
    
    func filter(by index: Int) {
        let calendar = Calendar.current
        let now = Date()
        var filtered: [TransactionModel] = []
        
        
        switch index {
        case 0:
            filtered = filterdHistory.filter { calendar.isDateInToday($0.date) }
        case 1:
            filtered = filterdHistory.filter { calendar.isDate($0.date, equalTo: now, toGranularity: .weekOfYear) }
        case 2:
            filtered = filterdHistory.filter { calendar.isDate($0.date, equalTo: now, toGranularity: .month) }
        case 3:
            filtered = filterdHistory.filter { calendar.isDate($0.date, equalTo: now, toGranularity: .year) }
        default:
            filtered = filterdHistory
        }
        
        allHistory = filtered
        delegate?.didReceiveReloadData()
    }
}

