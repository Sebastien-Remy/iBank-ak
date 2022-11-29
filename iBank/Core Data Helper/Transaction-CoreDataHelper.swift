//
//  Transaction-CoreDataHelper.swift
//  iBank
//
//  Created by Sebastien REMY on 10/11/2022.
//

import Foundation

extension Transaction {
    
    var transactionDate: Date {
        get { date ?? Date() }
        set {
            guard managedObjectContext  != nil else { return }
            date = newValue
        }
    }
    
    var transactionTitle: String {
        get { title ?? "" }
        set {
            guard managedObjectContext  != nil else { return }
            title = newValue
        }
    }
    
    var transactionStatus: String {
        get {
            return TransactionStatus(rawValue: Int(status))?.statusString ?? TransactionStatus.engaged.statusString
        }
        set {
            guard managedObjectContext  != nil else { return }
        }
    }
    

}
