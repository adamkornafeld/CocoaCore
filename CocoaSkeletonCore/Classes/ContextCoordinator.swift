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
    
    var persistentStoreCoordinatorOptions: NSDictionary {
        get {
            return [NSMigratePersistentStoresAutomaticallyOption: true,
                    NSInferMappingModelAutomaticallyOption: true];
        }
    }
    
    var _mainQueueContext: NSManagedObjectContext? {
        didSet {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(contextDidSave), name: NSManagedObjectContextDidSaveNotification, object: _mainQueueContext)
        }
    }
    public var mainQueueContext: NSManagedObjectContext? {
        get {
            if (_mainQueueContext == nil) {
                let bundle = NSBundle(forClass: self.dynamicType)
                let coordinator = NSPersistentStoreCoordinator.coordinatorForModelWithName("Data", options: self.persistentStoreCoordinatorOptions, bundle: bundle)
                
                let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
                context.persistentStoreCoordinator = coordinator
                _mainQueueContext = context
            }
            return _mainQueueContext
        }
    }
    
    var _backgroundQueueContext: NSManagedObjectContext? {
        didSet {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(contextDidSave), name: NSManagedObjectContextDidSaveNotification, object: _backgroundQueueContext)
        }
    }
    public var backgroundQueueContext: NSManagedObjectContext? {
        get {
            if (_backgroundQueueContext == nil) {
                let bundle = NSBundle(forClass: self.dynamicType)
                let coordinator = NSPersistentStoreCoordinator.coordinatorForModelWithName("Data", options: self.persistentStoreCoordinatorOptions, bundle: bundle)
                
                let context = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
                context.persistentStoreCoordinator = coordinator
                _backgroundQueueContext = context
            }
            return _backgroundQueueContext
        }
    }
    
    func contextDidSave(notification: NSNotification) {
        if let context = notification.object as? NSManagedObjectContext {
            if (context == self.mainQueueContext) {
                DDLogVerbose("backgroundQueueContext mergeChangesFromContextDidSaveNotification()")
                self.backgroundQueueContext?.mergeChangesFromContextDidSaveNotification(notification)
            }
            else if (context == self.backgroundQueueContext) {
                DDLogVerbose("mainQueueContext mergeChangesFromContextDidSaveNotification")
                self.mainQueueContext?.mergeChangesFromContextDidSaveNotification(notification)
            }
        }
    }
    
    override init() {
        DDLogVerbose("ContextCoordinator init")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NSManagedObjectContextDidSaveNotification, object: _mainQueueContext)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NSManagedObjectContextDidSaveNotification, object: _backgroundQueueContext)
    }
}
