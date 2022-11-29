//
//  Account-CoreDataHelpers.swift
//  iBank
//
//  Created by Sebastien REMY on 08/11/2022.
//

import AppKit
import SwiftUI

extension Account {
    
    convenience init(context: NSManagedObjectContext,
                     name: String,
                     originalBalance: Double) {
        self.init(context: context)
        self.name = name
        self.originalBalance = originalBalance
        self.colorAsHex = NSColor(Color.primary).hexString
        self.iconName = Constants.Account.iconName
    }
    
    var accountName: String {
        get { name ?? "" }
        set {
            guard managedObjectContext  != nil else { return }
            name = newValue
        }
    }
    
    var accountColor: NSColor {
        get { NSColor(fromHexString: colorAsHex) ?? NSColor(Color.primary) }
        set {
            guard managedObjectContext  != nil else { return }
            colorAsHex = newValue.hexString
        }
    }
    
    var accountIconName: String {
        get {
            let systemName = iconName ?? Constants.Account.iconName
            if NSImage(systemSymbolName: systemName, accessibilityDescription: "") == nil { return Constants.Account.iconName }
            return systemName
             }
        set {
            guard managedObjectContext  != nil else { return }
            iconName = newValue
        }
    }
    
    var accountTransactions: [Transaction] {
        let set = transactions as? Set<Transaction> ?? []
        return set.sorted {
            $0.transactionDate < $1.transactionDate
        }
    }
}
