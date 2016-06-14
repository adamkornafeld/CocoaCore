//
//  App.swift
//  CocoaCore
//
//  Created by Adam Kornafeld on 6/12/16.
//  Copyright © 2016 Adam Kornafeld. All rights reserved.
//

import Foundation
import CocoaLumberjackSwift

public class App {
    
    public static let instance = App()
    
    public let contextCoordinator = ContextCoordinator()
    
    public init() {
        DDLogVerbose("App init")
    }
    
}
