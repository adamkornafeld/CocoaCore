//
//  NSPersistentStoreCoordinator+Helper.swift
//  CocoaCore
//
//  Created by Adam Kornafeld on 6/12/16.
//  Copyright © 2016 Adam Kornafeld. All rights reserved.
//

import Foundation
import CoreData

extension NSPersistentStoreCoordinator {
    
    class func coordinatorForModelWithName(name: String, options: NSDictionary, bundle: NSBundle) -> NSPersistentStoreCoordinator {
        let model = NSManagedObjectModel.modelNamed(name, bundle: bundle)
        let coordinator = NSPersistentStoreCoordinator.init(managedObjectModel: model)
        let storeURL = NSPersistentStoreCoordinator.storeURLForName(name)
        
        try! coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: options as [NSObject : AnyObject])
        return coordinator
    }
    
    class func storeURLForName(name: String) -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        let documentsDirectoryURL = try? fileManager.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true);
        return documentsDirectoryURL!.URLByAppendingPathComponent("sqlite")
    }
    
}
