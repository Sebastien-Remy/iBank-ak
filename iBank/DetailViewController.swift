//
//  DetailViewController.swift
//  iBank
//
//  Created by Sebastien REMY on 26/11/2022.
//

import Cocoa

class DetailViewController: NSViewController {

    @IBOutlet var mainInformation: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
        mainInformation.stringValue = "Select something !"
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(doWhenNotify),
                                               name: Constants.Notification.viewSelectionChanged,
                                               object: nil)
    }
    
    @objc func doWhenNotify(_ notification: NSNotification) {
         
        if notification.object == nil {
            mainInformation.stringValue = "Select something !"
        }
        
        if let section = notification.object as? Section {
            mainInformation.stringValue = section.name
        }
    }
}
