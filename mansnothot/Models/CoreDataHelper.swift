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
    
    //add function to removeSavedInfo
}
