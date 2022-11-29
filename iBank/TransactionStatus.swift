//
//  TransactionStatus.swift
//  iBank
//
//  Created by Sebastien REMY on 21/11/2022.
//

import Foundation
enum TransactionStatus: Int, Comparable {
    static var allStatus = [TransactionStatus.planned, TransactionStatus.engaged, TransactionStatus.checked]
    
    case planned, engaged, checked
    
    var statusString: String {
        switch self {
        case .planned: return "Planned"
        case .engaged: return "Engaged"
        case .checked: return "Checked"
        }
    }
    static func < (lhs: TransactionStatus, rhs: TransactionStatus) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}


