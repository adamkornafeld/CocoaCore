//
//  NSManagedObjectContext+Helper.swift
//  CocoaCore
//
//  Created by Adam Kornafeld on 6/12/16.
//  Copyright © 2016 Adam Kornafeld. All rights reserved.
//

import Foundation
import CoreData
import CocoaLumberjackSwift

public extension NSManagedObjectContext {
    
    public func managedObjectsOfClass(className: NSManagedObject.Type, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [AnyObject] {
        let entityName = NSStringFromClass(className)
        let request = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = sortDescriptors
        request.predicate = predicate
        do {
            let managedObjects = try self.executeFetchRequest(request)
            return (managedObjects.count > 0) ? managedObjects : []
        }
        catch let error {
            DDLogError("\(error)")
            return []
        }
    }
    
    public func managedObjectsOfClass(className: NSManagedObject.Type, predicate: NSPredicate?) -> [AnyObject] {
        return self.managedObjectsOfClass(className, predicate: predicate, sortDescriptors: nil)
    }
    
    public func managedObjectOfClass(className: NSManagedObject.Type, predicate: NSPredicate?) -> AnyObject? {
        let results = self.managedObjectsOfClass(className, predicate: predicate)
        return (results.count > 0) ? results.first : nil
    }
    
}
