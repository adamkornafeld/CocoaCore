//
//  LogFormatter.swift
//  CocoaCore
//
//  Created by Adam Kornafeld on 6/13/16.
//  Copyright © 2016 Adam Kornafeld. All rights reserved.
//

import Foundation
import CocoaLumberjack.DDDispatchQueueLogFormatter

public class LogFormatter: DDDispatchQueueLogFormatter {
    let dateFormatter: NSDateFormatter
    
    public override init() {
        dateFormatter = NSDateFormatter()
        dateFormatter.formatterBehavior = .Behavior10_4
        dateFormatter.dateFormat = "HH:mm"
        
        super.init()
    }
    
    public override func formatLogMessage(logMessage: DDLogMessage!) -> String {
        let dateAndTime = dateFormatter.stringFromDate(logMessage.timestamp)
        return "\(dateAndTime) [\(logMessage.fileName):\(logMessage.line)]: \(logMessage.message)"
    }
}