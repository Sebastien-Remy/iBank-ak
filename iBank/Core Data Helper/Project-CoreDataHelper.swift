//
//  Project-CoreDataHelper.swift
//  iBank
//
//  Created by Sebastien REMY on 08/11/2022.
//

import AppKit
import SwiftUI

extension Project {
    
    convenience init(context: NSManagedObjectContext,
                     name: String) {
        self.init(context: context)
        self.name = name
        self.iconName = Constants.Project.iconName
    }
    
    var projectName: String {
        get { name ?? "" }
        set {
            guard managedObjectContext  != nil else { return }
            name = newValue
        }
    }
    
    var projectIconName: String {
        get {
            let systemName = iconName ?? Constants.Project.iconName
            if NSImage(systemSymbolName: systemName, accessibilityDescription: "") == nil { return Constants.Project.iconName }
            return systemName
        }
        set {
            guard managedObjectContext  != nil else { return }
            iconName = newValue
        }
    }
    
    var projectColor: NSColor {
        get { NSColor(fromHexString: colorAsHex) ?? NSColor(Color.primary)}
        set {
            guard managedObjectContext  != nil else { return }
            colorAsHex = newValue.hexString
        }
    }
}
