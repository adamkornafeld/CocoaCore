//
//  NSManagedObjectContext+Helper.swift
//  CocoaCore
//
//  Created by Adam Kornafeld on 6/12/16.
//  Copyright © 2016 Adam Kornafeld. All rights reserved.
//

import Foundation
import CoreData

public extension NSManagedObjectContext {
    
    public func managedObjectsOfClass(className: NSManagedObject.Type, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [AnyObject] {
        let entityName = NSStringFromClass(className)
        let request = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = sortDescriptors
        request.predicate = predicate
        let managedObjects = try! self.executeFetchRequest(request)
        return managedObjects
    }
    
    public func managedObjectsOfClass(className: NSManagedObject.Type, predicate: NSPredicate?) -> [AnyObject] {
        return self.managedObjectsOfClass(className, predicate: predicate, sortDescriptors: nil)
    }
    
    public func managedObjectOfClass(className: NSManagedObject.Type, predicate: NSPredicate?) -> AnyObject? {
        let results = self.managedObjectsOfClass(className, predicate: predicate)
        return results!.first
    }
    
    public func managedObjectOfClass(className: AnyClass, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> AnyObject? {
        let results = self.managedObjectsOfClass(className, predicate: predicate, sortDescriptors: sortDescriptors)
        return results!.first
    }
    
}
