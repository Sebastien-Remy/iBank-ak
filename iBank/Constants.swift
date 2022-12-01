//
//  Constants.swift
//  iBank
//
//  Created by Sebastien REMY on 21/11/2022.
//

import Foundation

struct Constants {
    struct Notification {
        static let viewSelectionChanged = NSNotification.Name(rawValue: "fr.ibank.viewSelectionChanged")
    }
    struct Account {
        static let iconName = "building.columns"
    }
    struct Category {
        static let iconName = "tag"
    }
    struct Project {
        static let iconName = "bag"
    }
    struct Third {
        static let iconName = "person"
    }
}
