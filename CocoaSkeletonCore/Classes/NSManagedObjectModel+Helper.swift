//
//  NSManagedObjectModel+Helper.swift
//  CocoaCore
//
//  Created by Adam Kornafeld on 6/12/16.
//  Copyright © 2016 Adam Kornafeld. All rights reserved.
//

import Foundation
import CoreData

enum NSManagedObjectModelError : ErrorType {
    case ModelDoesNotExist
}

extension NSManagedObjectModel {
    
    class func modelNamed(name: String, bundle: NSBundle) throws -> NSManagedObjectModel {
        if let modelURL = bundle.URLForResource(name, withExtension: "momd") {
            if let model = NSManagedObjectModel.init(contentsOfURL: modelURL) {
                return model
            }
        }
        throw NSManagedObjectModelError.ModelDoesNotExist
    }
}
