//
//  CateogryCoreDataHelpers.swift
//  iBank
//
//  Created by Sebastien REMY on 08/11/2022.
//

import AppKit
import SwiftUI

extension Category {
    
    convenience init(context: NSManagedObjectContext,
                     name: String) {
        self.init(context: context)
        self.name = name
        self.iconName = Constants.Category.iconName
    }
    
    var categoryColor: NSColor {
        get { NSColor(fromHexString: colorAsHex) ?? NSColor(Color.primary) }
        set {
            guard managedObjectContext  != nil else { return }
            colorAsHex = newValue.hexString
        }
    }
    
    var categoryIconName: String {
        get {
            let systemName = iconName ?? Constants.Category.iconName
            if NSImage(systemSymbolName: systemName, accessibilityDescription: "") == nil { return Constants.Category.iconName }
            return systemName
        }
        set {
            guard managedObjectContext  != nil else { return }
            iconName = newValue
        }
    }
    
    var categoryName: String {
        get { name ?? "" }
        set {
            guard managedObjectContext  != nil else { return }
            name = newValue
        }
    }
}
