//
//  ColorToHex-Extension.swift
//  iBank
//
//  Created by Sebastien REMY on 21/11/2022.
//

import SwiftUI
import AppKit


import Cocoa

extension NSColor {
    
    var hexString: String {
        let red = Int(round(self.redComponent * 0xFF))
        let green = Int(round(self.greenComponent * 0xFF))
        let blue = Int(round(self.blueComponent * 0xFF))
        let hexString = NSString(format: "#%02X%02X%02X", red, green, blue)
        return hexString as String
    }
    
}
