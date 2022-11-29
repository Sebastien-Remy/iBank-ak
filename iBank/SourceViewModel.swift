//
//  SourceViewModel.swift
//  iBank
//
//  Created by Sebastien REMY on 28/11/2022.
//

import AppKit

@objc
class SourceViewModel: NSObject {
    
    var container: NSPersistentContainer!
    var context: NSManagedObjectContext!
    var sections: [Section] = []
    
    override init() {
        super.init()
        self.container = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer
        self.context = container.viewContext
        
        // Create sections
        
        sections.append(Section(name: "Group", entity: .accountGroup, items: accountGroups))
        sections.append(Section(name: "Category", entity: .category, items: categories))
        sections.append(Section(name: "Third", entity: .third, items: thirds))
        sections.append(Section(name: "Project", entity: .project, items: projects))
    }
    
    func save() {
        do {
            try  context.save()
        } catch {
            print ("coredata error")
            return
        }
    }
    
    // MARK: - AccountGroup
    
    func accountGroups() -> [AccountGroup] {
        let request = AccountGroup.fetchRequest()
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print ("ERROR in CoreData")
            return []
        }
    }
    
    func addAccountGroup() -> AccountGroup {
        let newItem = AccountGroup(context: context)
        newItem.name = "AC Group"
        save()
        return newItem
    }
    
    func deleteAccountGroup(_ item: AccountGroup) {
        context.delete(item)
        save()
    }
    
    // MARK: - Account
    func accounts() -> [Account] {
        let request = Account.fetchRequest()
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print ("ERROR in CoreData")
            return []
        }
    }
    
    func addAccount() -> Account {
        let newItem = Account(context: context)
        newItem.name = "Account"
        save()
        return newItem
    }
    
    func deleteAccount(_ item: Account) {
        context.delete(item)
        save()
    }
    
    
    // MARK: - Category
    
    func categories() -> [Category] {
        let request = Category.fetchRequest()
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print ("ERROR in CoreData")
            return []
        }
    }
    
    func addCategory() -> Category {
        let newItem = Category(context: context)
        newItem.name = "Category"
        save()
        return newItem
    }
    
    func deleteCategory(_ item: Category) {
        context.delete(item)
        save()
    }
    
    // MARK: - Thirds
    func thirds() -> [Third] {
        let request = Third.fetchRequest()
        do {
            
            let result = try context.fetch(request)
            return result
        } catch {
            
            print ("ERROR in CoreData")
            return []
        }
    }
    
    func addThird() -> Third {
        let newItem = Third(context: context)
        newItem.name = "Third"
        save()
        return newItem
    }
    
    func deleteThird(_ item: Third) {
        context.delete(item)
        save()
    }
    
    // MARK: - Projects
    func projects() -> [Project] {
        let request = Project.fetchRequest()
        do {
            
            let result = try context.fetch(request)
            return result
        } catch {
            
            print ("ERROR in CoreData")
            return []
        }
    }
    
    func addProject() -> Project {
        let newItem = Project(context: context)
        newItem.name = "Project"
        save()
        return newItem
    }
    
    func deleteProject(_ item: Project) {
        context.delete(item)
        save()
    }
}

class Section {
    var name: String
    var entity: SectionEntity
    var items: () -> [Any]
    init(name: String, entity: SectionEntity, items: @escaping () -> [Any]) {
        self.name = name
        self.entity = entity
        self.items = items
    }
}

enum SectionEntity: Int {
    case accountGroup, account, category, third, project
}
