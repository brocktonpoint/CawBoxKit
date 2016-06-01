/*
The MIT License (MIT)

Copyright (c) 2015 CawBox

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import Foundation

public typealias Semaphore = dispatch_semaphore_t
public typealias Dispatch = dispatch_queue_t

public enum DispatchPriority {
    case UI
    case Low
    case Default
    case High
    case Background
}

public func GetDispatch (priority: DispatchPriority) -> Dispatch {
    switch priority {
    case .UI:
        return dispatch_get_main_queue()
    case .Low:
        return dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_LOW, 0)
    case .Default:
        return dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    case .High:
        return dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_HIGH, 0)
    case .Background:
        return dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
    }
}
public extension Dispatch {
    public func async (block: dispatch_block_t) {
        dispatch_async (self, block)
    }
    
    public func after (seconds: Double, block: dispatch_block_t) {
        dispatch_after (dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC))), self, block)
    }
}
public extension Semaphore {
    public static func create () -> Semaphore {
        return dispatch_semaphore_create (0)
    }
    
    public func lock () {
        dispatch_semaphore_wait (self, DISPATCH_TIME_FOREVER)
    }
    public func unlock () {
        dispatch_semaphore_signal (self)
    }
    
    public static func asyncAndWait (process: () -> Void) {
        let semaphore = self.create ()
        
        GetDispatch (priority: .High).async {
            process ()
            
            semaphore.unlock ()
        }
        semaphore.lock ()
    }
}
