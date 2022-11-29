//
//  AccountGroup.swift
//  iBank
//
//  Created by Sebastien REMY on 28/11/2022.
//

import AppKit
import SwiftUI

extension AccountGroup {
    
    convenience init(context: NSManagedObjectContext,
                     name: String) {
        self.init(context: context)
        self.name = name
        self.iconName = Constants.Account.iconName
    }
    
    var accountGroupName: String {
        get { name ?? "" }
        set {
            guard managedObjectContext  != nil else { return }
            name = newValue
        }
    }
    var accountGroupIconName: String {
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
    
    var accountGroupColor: NSColor {
        get { NSColor(fromHexString: colorAsHex) ?? NSColor(Color.primary) }
        set {
            guard managedObjectContext  != nil else { return }
            colorAsHex = newValue.hexString
        }
    }
}
