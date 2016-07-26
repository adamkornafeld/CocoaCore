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
    
    class func coordinatorForModelWithName(name: String, storeType: String, options: [NSObject: AnyObject], bundle: NSBundle) throws -> NSPersistentStoreCoordinator {
        let model = try NSManagedObjectModel.modelNamed(name, bundle: bundle)
        let coordinator = NSPersistentStoreCoordinator.init(managedObjectModel: model)
        let storeURL = try NSPersistentStoreCoordinator.storeURLForName(name)
        try coordinator.addPersistentStoreWithType(storeType, configuration: nil, URL: storeURL, options: options)
        return coordinator
    }
    
    class func storeURLForName(name: String) -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        let documentsDirectoryURL = try? fileManager.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true);
        return documentsDirectoryURL!.URLByAppendingPathComponent("sqlite")
    }
    
}
