//
//  SourceViewController.swift
//  iBank
//
//  Created by Sebastien REMY on 26/11/2022.
//

import Cocoa

class SourceViewController: NSViewController {
    
    // MARK: - Outlet
    @IBOutlet var outlineView: NSOutlineView!
    
    // MARK: Var
    private var viewModel = SourceViewModel()
    private let contextMenu = NSMenu(title: "Context")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View setup
        contextMenu.delegate = self
        outlineView.menu = contextMenu
    }
}

// MARK: - NSOutlineViewDataSource
extension SourceViewController: NSOutlineViewDataSource {
    
    func outlineView(_ outlineView: NSOutlineView,
                     numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil {
            // Root
            return viewModel.sections.count
        }
        
        if let s = item as? Section {
            return s.items().count
        }
        
        print("errror in DataSource")
        return 0
    }
    
    func outlineView(_ outlineView: NSOutlineView,
                     child index: Int,
                     ofItem item: Any?) -> Any {
        if item == nil {
            // Root
            return viewModel.sections[index]
        } else {
            if let section = item as? Section {
                // Section
                return section.items()[index]
            } else {
                print("err")
                return item ?? ""
            }
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView,
                     isItemExpandable item: Any) -> Bool {
        guard let _ = item as? Section else { return false }
        return true
    }
}

// MARK: - NSOutlineViewDelegate
extension SourceViewController: NSOutlineViewDelegate {
    func outlineView(_ outlineView: NSOutlineView,
                     viewFor tableColumn: NSTableColumn?,
                     item: Any) -> NSView? {
        guard let colIdentifier = tableColumn?.identifier else { return nil }
        
        
        if colIdentifier == NSUserInterfaceItemIdentifier("titleCol") {
            // Title
            let cellIdentifier = NSUserInterfaceItemIdentifier("titleCell")
            guard let cell = outlineView.makeView(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView else { return nil }
            
            // Section ?
            if let section = item as? Section {
                cell.textField?.stringValue = section.name
                return cell

            }
            
            // Account Group
            if let accountGroup = item as? AccountGroup {
                cell.textField?.stringValue = accountGroup.accountGroupName
                cell.textField?.isEditable = true
                cell.textField?.delegate = self
                return cell
                
            }
            
            if let category = item as? Category {
                cell.textField?.stringValue = category.categoryName
                cell.textField?.isEditable = true
                cell.textField?.delegate = self
                return cell
                
            }
            // other
                cell.textField?.stringValue = "CRASH other"
                return cell
            
        } else {
            // previewCol
            
            let cellIdentifier = NSUserInterfaceItemIdentifier("previewCell")
            guard let cell = outlineView.makeView(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView else { return nil }
            
            cell.textField?.stringValue = "0,00 €"
            return cell
        }
    }
}

// MARK: - NSTextFieldDelegate
extension SourceViewController: NSTextFieldDelegate {
    func control(_ control: NSControl, textShouldEndEditing fieldEditor: NSText) -> Bool {
         
        if let accountGroup = outlineView.item(atRow: outlineView.selectedRow) as? AccountGroup {
            accountGroup.accountGroupName = (control as! NSTextField).stringValue
            viewModel.save()
        }
        
        if let category = outlineView.item(atRow: outlineView.selectedRow) as? Category {
            category.categoryName = (control as! NSTextField).stringValue
            viewModel.save()
        }
        
        return true
    }
}

// MARK: - NSMenuDelegate
extension SourceViewController: NSMenuDelegate {
    

    func menuNeedsUpdate(_ menu: NSMenu) {
        
        let section = outlineView.item(atRow: outlineView.clickedRow) as? Section
        let accountGroup = outlineView.item(atRow: outlineView.clickedRow) as? AccountGroup
        
        // Clear Menu
        menu.removeAllItems()
        
        // Right clicked on Section ?
        if (section != nil) {
            menu.addItem(NSMenuItem(title: "Add",
                                    action: #selector(addMenuItemPressed),
                                    keyEquivalent: ""))
        }
       
        // Right clicked on an item ?
        if (section == nil) {
                menu.addItem(NSMenuItem(title: "Delete",
                                    action: #selector(deleteMenuItemPressed),
                                    keyEquivalent: ""))
        }
    }
    
    @objc func deleteMenuItemPressed() {
        
        var entity: SectionEntity?
        
        // Account Group ?
        if let item = outlineView.item(atRow: outlineView.clickedRow) as? AccountGroup {
            viewModel.deleteAccountGroup(item)
            entity = .accountGroup
        }
        
        // Category ?
        if let item = outlineView.item(atRow: outlineView.clickedRow) as? Category {
            viewModel.deleteCategory(item)
            entity = .category
        }
        
        
        // Refresh UI
        outlineView.reloadData()
        if let index = viewModel.sections.firstIndex(where: { $0.entity == entity }) {
            outlineView.expandItem(viewModel.sections[index])
        }
    }
    
    @objc func addMenuItemPressed() {
        
        var entity: SectionEntity?
        var newItem: Any?
        
        let section = outlineView.item(atRow: outlineView.clickedRow) as? Section
        
        if (section?.entity == .accountGroup) {
            newItem = viewModel.addAccountGroup()
            entity = .accountGroup
        }
        
        if (section?.entity == .category) {
            newItem = viewModel.addCategory()
            entity = .category
        }
        
        if let index = viewModel.sections.firstIndex(where: { $0.entity == entity }) {
            outlineView.expandItem(viewModel.sections[index])
        }
        
        outlineView.reloadData()
        
        let rowIndex = outlineView.row(forItem: newItem)
        if rowIndex > -1 {
            outlineView.selectRowIndexes(IndexSet(integer: rowIndex), byExtendingSelection: false)
        }
    }
    
}


