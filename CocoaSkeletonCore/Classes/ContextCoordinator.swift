//
//  ContextCoordinator.swift
//  CocoaCore
//
//  Created by Adam Kornafeld on 6/12/16.
//  Copyright © 2016 Adam Kornafeld. All rights reserved.
//

import Foundation
import CoreData
import CocoaLumberjackSwift

@objc
public class ContextCoordinator : NSObject {
    
    class var persistentStoreCoordinatorOptions: [NSObject: AnyObject] {
        return [NSMigratePersistentStoresAutomaticallyOption: true,
                NSInferMappingModelAutomaticallyOption: true]
    }
    
    let coordinator: NSPersistentStoreCoordinator
    
    lazy public var mainQueueContext: NSManagedObjectContext = { [unowned self] in
        let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.coordinator
        
        NSNotificationCenter.defaultCenter().addObserverForName(NSManagedObjectContextDidSaveNotification, object: context, queue: nil, usingBlock: { (notification) in
            let context = self.backgroundQueueContext
            context.performBlock({
                DDLogVerbose("backgroundQueueContext mergeChangesFromContextDidSaveNotification")
                context.mergeChangesFromContextDidSaveNotification(notification)
            })
        })
        
        return context
        }()
    
    lazy public var backgroundQueueContext: NSManagedObjectContext = { [unowned self] in
        let context = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        context.persistentStoreCoordinator = self.coordinator
        
        NSNotificationCenter.defaultCenter().addObserverForName(NSManagedObjectContextDidSaveNotification, object: context, queue: nil, usingBlock: { (notification) in
            let context = self.mainQueueContext
            context.performBlock({
                DDLogVerbose("mainQueueContext mergeChangesFromContextDidSaveNotification()")
                context.mergeChangesFromContextDidSaveNotification(notification)
            })
        })
        
        return context
        }()
    
    public init?(storeType: String, bundle: NSBundle) {
        do {
            coordinator = try NSPersistentStoreCoordinator.coordinatorForModelWithName("Data", storeType: storeType, options: ContextCoordinator.persistentStoreCoordinatorOptions, bundle: bundle)
            super.init()
            DDLogVerbose("ContextCoordinator init")
        }
        catch let error {
            DDLogError("\(error)")
            return nil
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NSManagedObjectContextDidSaveNotification, object: nil) // removes both
    }
}
