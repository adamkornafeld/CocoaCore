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

public class ContextCoordinator {
    
    var persistentStoreCoordinatorOptions: NSDictionary {
        get {
            return [NSMigratePersistentStoresAutomaticallyOption: true,
                    NSInferMappingModelAutomaticallyOption: true];
        }
    }
    
    public var mainQueueContext: NSManagedObjectContext {
        get {
            let bundle = NSBundle(forClass: self.dynamicType)
            let coordinator = NSPersistentStoreCoordinator.coordinatorForModelWithName("Data", options: self.persistentStoreCoordinatorOptions, bundle: bundle)
            
            let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
            context.persistentStoreCoordinator = coordinator
            return context
        }
    }
    
    init() {
        DDLogVerbose("ContextCoordinator init")
    }
}
