//
//  CoreDataHelper.swift
//  mansnothot
//
//  Created by C4Q on 2/9/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHelper {
    private init() {}
    static let manager = CoreDataHelper()
    private var delegate = (UIApplication.shared.delegate as! AppDelegate)
    
    public func getCurrentContext() -> NSManagedObjectContext {
        return delegate.persistentContainer.viewContext
    }
    
    public func saveContext() {
        delegate.saveContext()
    }
    
    public func removeSavedContext(completion: @escaping (_ user: Bool, _ post: Bool) -> Void) {
        let postsFetch = NSFetchRequest<NSFetchRequestResult>.init(entityName: "SavedPost")
        let postDeleteRequest = NSBatchDeleteRequest(fetchRequest: postsFetch)
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedUser")
        let userDeleteRequest = NSBatchDeleteRequest(fetchRequest: userFetch)
        
        var postDeleteSuccess = false
        var userDeleteSuccess = false
        
        do {
            try getCurrentContext().execute(postDeleteRequest)
            postDeleteSuccess = true
            try getCurrentContext().execute(userDeleteRequest)
            userDeleteSuccess = true
        } catch {
            print(error)
        }
        completion(userDeleteSuccess, postDeleteSuccess)
    }
}
