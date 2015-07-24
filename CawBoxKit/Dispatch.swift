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

typealias Semaphore = dispatch_semaphore_t

extension Semaphore
{
    class func create () -> Semaphore {
        return dispatch_semaphore_create (0)
    }
    
    func lock () {
        dispatch_semaphore_wait (self, DISPATCH_TIME_FOREVER)
    }
    func unlock () {
        dispatch_semaphore_signal (self)
    }
    
    class func asyncAndWait (process: () -> Void) {
        let semaphore = self.create ()
        
        Dispatch.high.async {
            process ()
            
            semaphore.unlock ()
        }
        semaphore.lock ()
    }
}

typealias Dispatch = dispatch_queue_t

extension Dispatch
{
    class var ui: Dispatch {
        return dispatch_get_main_queue ()
    }
    
    class var low: Dispatch {
        return dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_LOW, 0)
    }
    class var regular: Dispatch {
        return dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    }
    class var high: Dispatch {
        return dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_HIGH, 0)
    }
    class var background: Dispatch {
        return dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
    }
    
    func async (block: dispatch_block_t) {
        dispatch_async (self, block)
    }
    
    func after (seconds: Double, block: dispatch_block_t) {
        dispatch_after (dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC))), self, block)
    }
}
