//
//  UserDefaults+Ext.swift
//  CashRegister
//
//  Created by Elchın on 01.04.26.
//

import Foundation

extension UserDefaults {
    enum Keys: String {
        case checkCash = "!!98sd8s9d8s9d"
        case cashModel = "asd989d8s9da9sd"
        case historyModel = "@@2939asdnsafgk"
    }
    
    var checkCashInfo: Bool {
        get {
            return bool(forKey: Keys.checkCash.rawValue)
        }
        
        set {
            setValue(newValue, forKey: Keys.checkCash.rawValue)
        }
    }
    
    var saveCashModel: Data? {
        get {
            return data(forKey: Keys.cashModel.rawValue)
        }
        
        set {
            setValue(newValue, forKey: Keys.cashModel.rawValue)
        }
    }
    
    var historyModelInfo: Data? {
        get {
            return data(forKey: Keys.historyModel.rawValue)
        }
        
        set {
            setValue(newValue, forKey: Keys.historyModel.rawValue)
        }
    }
}
