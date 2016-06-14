//
//  NSManagedObjectModel+Helper.swift
//  CocoaCore
//
//  Created by Adam Kornafeld on 6/12/16.
//  Copyright © 2016 Adam Kornafeld. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectModel {
    
    class func modelNamed(name: String, bundle: NSBundle) -> NSManagedObjectModel {
        let modelURL = bundle.URLForResource(name, withExtension: "momd")
        let model = NSManagedObjectModel.init(contentsOfURL: modelURL!)
        return model!
    }
    
}
